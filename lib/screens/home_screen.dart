import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/models/transaction.dart';
import 'package:projeto_despesas_pessoais/widgets/transaction_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, Object>> _categoriesMap = [
    {
      'title': 'Alimentos',
      'icon': const Icon(Icons.restaurant),
      'color': const Color(0XFFF5C93C),
      'transitions': [],
    },
    {
      'title': 'Faturas',
      'icon': const Icon(Icons.attach_money),
      'color': const Color(0XFF01D99F),
      'transactions': [],
    },
    {
      'title': 'Transporte',
      'icon': const Icon(Icons.emoji_transportation),
      'color': const Color(0XFF36B5EB),
      'transactions': [],
    },
    {
      'title': 'Moradia',
      'icon': const Icon(Icons.house_rounded),
      'color': const Color(0XFF897AF1),
      'transactions': [],
    },
    {
      'title': 'Outros',
      'icon': const Icon(Icons.more),
      'color': const Color(0XFFF43460),
      'transactions': [],
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    // setState(() {
    //   _transactions.add(newTransaction);
    //   storage.saveTransactions(_transactions);
    // });

    Navigator.of(context).pop();
  }

  _openTrasactionFormModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: TransactionForm(
              onSubmit: _addTransaction,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          surfaceTintColor: Theme.of(context).colorScheme.background,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Minhas Despesas'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Title Large 123',
                style: Theme.of(context).textTheme.titleLarge),
            Text('Title Medium 123',
                style: Theme.of(context).textTheme.titleMedium),
            Text('Title Small 123',
                style: Theme.of(context).textTheme.titleSmall),
            Text('Body Large 123',
                style: Theme.of(context).textTheme.bodyLarge),
            Text('Body Medium 123',
                style: Theme.of(context).textTheme.bodyMedium),
            Text('Body Small 123',
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _categoriesMap[_selectedIndex]['color'] as Color,
        onPressed: () => _openTrasactionFormModal(context),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _categoriesMap.map((category) {
          return BottomNavigationBarItem(
            label: category['title'] as String,
            icon: category['icon'] as Widget,
            backgroundColor: Theme.of(context).colorScheme.primary,
          );
        }).toList(),
        selectedItemColor: _categoriesMap[_selectedIndex]['color'] as Color,
        unselectedItemColor: const Color(0XFFE0E3E8),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}