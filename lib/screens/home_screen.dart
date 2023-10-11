import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/components/drawer.dart';
import 'package:projeto_despesas_pessoais/data/data.dart';
import 'package:projeto_despesas_pessoais/models/transaction.dart';
import 'package:projeto_despesas_pessoais/widgets/transaction_form.dart';
import 'package:projeto_despesas_pessoais/widgets/transaction_list.dart';

class HomeScreen extends StatefulWidget {
  final Function() changeTheme;

  const HomeScreen({
    super.key,
    required this.changeTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final TransactionStorage storage = TransactionStorage();
  List<Transaction> _transactions = [];

  final List<Map<String, Object>> _categoriesMap = [
    {
      'title': 'Alimentos',
      'icon': const Icon(Icons.restaurant),
      'color': const Color(0XFFF5C93C),
      'transactionValue': '0',
    },
    {
      'title': 'Faturas',
      'icon': const Icon(Icons.attach_money),
      'color': const Color(0XFF01D99F),
      'transactionValue': '1',
    },
    {
      'title': 'Transporte',
      'icon': const Icon(Icons.emoji_transportation),
      'color': const Color(0XFF36B5EB),
      'transactionValue': '2',
    },
    {
      'title': 'Moradia',
      'icon': const Icon(Icons.house_rounded),
      'color': const Color(0XFF897AF1),
      'transactionValue': '3',
    },
    {
      'title': 'Outros',
      'icon': const Icon(Icons.more),
      'color': const Color(0XFFF43460),
      'transactionValue': '4',
    },
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   loadTransactions();
  // }

  // void loadTransactions() async {
  //   final transactions = await storage.getTransactions();
  //   setState(() {
  //     _transactions = transactions;
  //   });
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
      storage.saveTransactions(_transactions);
    });
  }

  void _clearTransactions() {
    setState(() {
      _transactions.clear();
    });
    Navigator.of(context).pop();
  }

  void _showConfirmBox() {
    Future.delayed(
      Duration.zero,
      () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titleTextStyle: Theme.of(context).textTheme.titleMedium,
              contentTextStyle: Theme.of(context).textTheme.bodyMedium,
              backgroundColor: Theme.of(context).colorScheme.background,
              surfaceTintColor: Theme.of(context).colorScheme.background,
              title: const Text('Confirmação'),
              content: const Text(
                  'Atenção: tem certeza que quer apagar todos os gastos cadastrados?'),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.bodySmall,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    _clearTransactions();
                    storage.saveTransactions(_transactions);
                  },
                  child: const Text('Sim'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.bodySmall,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                  ),
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

  void _addTransaction(
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

  void _openTrasactionFormModal(BuildContext context) {
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
          PopupMenuButton(
            color: Theme.of(context).colorScheme.background,
            icon: const Icon(
              Icons.settings,
              color: Color(0XFFE0E3E8),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: _showConfirmBox,
                child: Row(
                  children: [
                    Icon(
                      Icons.cleaning_services,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Limpar todos os gastos',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: widget.changeTheme,
                child: Row(
                  children: [
                    Icon(
                      Icons.brightness_4,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Alterar tema',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: const MyDrawer(),
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
            SizedBox(
              height: 200,
              child: TransactionList(
                transactions: _transactions.where((tr) {
                  return tr.categoryValue == _selectedIndex.toString();
                }).toList(),
                color: _categoriesMap[_selectedIndex]['color'] as Color,
                onRemove: _removeTransaction,
              ),
            )
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
