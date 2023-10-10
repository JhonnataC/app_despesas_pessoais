import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/data/data.dart';
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
  final TransactionStorage storage = TransactionStorage();
  List<Transaction> _transactions = [];
  bool _showChart = false;

  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  void loadTransactions() async {
    final transactions = await storage.getTransactions();
    setState(() {
      _transactions = transactions;
    });
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  double get _totalTransactions {
    double sum = 0.0;
    for (var tr in _transactions) {
      sum += tr.value;
    }
    return sum;
  }

  _addTransaction(
      String title, double value, DateTime date, String categoryValue) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
      categoryValue: categoryValue,
    );

    setState(() {
      _transactions.add(newTransaction);
      storage.saveTransactions(_transactions);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
      storage.saveTransactions(_transactions);
    });
  }

  _openTrasactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
                  onPressed: () {
                    _clearTransactions();
                    storage.saveTransactions(_transactions);
                  },
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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text('Despesas Pessoais'),
      actions: [
        if (isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            icon: Icon(_showChart ? Icons.list : Icons.show_chart_outlined),
          ),
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
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
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
            if (_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 0.7 : 0.3),
                child: Chart(
                  recentTransactions: _recentTransactions,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                'Total de gastos: \$${_totalTransactions.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(
                  transactions: _transactions,
                  onRemove: _removeTransaction,
                  color: Colors.black,
                ),
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
