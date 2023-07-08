import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/widgets/chart.dart';

import '../models/transaction.dart';
import '../widgets/transaction_form.dart';
import '../widgets/transaction_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't4',
      title: 'Coxinha',
      value: 4,
      date: DateTime.now().subtract(const Duration(days: 0)),
    )
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTrasactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(
          onSubmit: _addTransaction,
        );
      },
    );
  }

  _clearTransactions() {
    setState(() {
      _transactions.clear();
    });
    Navigator.of(context).pop();
  }

  _showConfirmBox() {
    Future.delayed(
      Duration.zero,
      () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirmação'),
              content:
                  const Text('Deseja realmente excluir todas as transações?'),
              actions: [
                TextButton(
                  onPressed: () => _clearTransactions(),
                  child: const Text('Sim'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  double get _totalTransactions {
    double sum = 0.0;
    for (var tr in _transactions) {
      sum += tr.value;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              // PopupMenuItem(
              //   onTap: () {},
              //   child: const Text('Alterar tema'),
              // ),
              PopupMenuItem(
                child: const Text('Limpar todas as transações'),
                onTap: () => _showConfirmBox(),
              ),
            ],
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                'Seus gastos nos últimos sete dias: ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Chart(
              recentTransactions: _recentTransactions,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                'Total de gastos: \$${_totalTransactions.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            TransactionList(
              transactions: _transactions,
              onRemove: _removeTransaction,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () => _openTrasactionFormModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
