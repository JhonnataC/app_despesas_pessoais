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
    // Transaction(
    //   id: 't0',
    //   title: 'Conta antiga',
    //   value: 500.50,
    //   date: DateTime.now().subtract(const Duration(days: 33)),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Novo tênis',
    //   value: 37,
    //   date: DateTime.now().subtract(const Duration(days: 1)),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Gta 6',
    //   value: 400,
    //   date: DateTime.now().subtract(const Duration(days: 2)),
    // ),
    // Transaction(
    //   id: 't3',
    //   title: 'Fatura do mês',
    //   value: 1000,
    //   date: DateTime.now().subtract(const Duration(days: 4)),
    // ),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                  child: const Text('Limpar lista de compras'),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext buildContext) {
                          return AlertDialog(
                            title: const Text(
                                'Deseja realmente excluir todas as transações?'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancelar'),
                              ),
                              ElevatedButton(
                                onPressed: () => _clearTransactions(),
                                child: const Text('Sim'),
                              ),
                            ],
                          );
                        });
                  }),
              PopupMenuItem(
                child: const Text('Alterar tema'),
                onTap: () {},
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
            Chart(recentTransactions: _recentTransactions),
            const SizedBox(
              height: 20,
            ),
            TransactionList(
              transactions: _transactions,
              onRemove: _removeTransaction,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTrasactionFormModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
