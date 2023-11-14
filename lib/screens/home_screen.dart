import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/data/data.dart';
import 'package:projeto_despesas_pessoais/models/transaction.dart';
import 'package:projeto_despesas_pessoais/utils/app_utils.dart';
import 'package:projeto_despesas_pessoais/components/chart.dart';
import 'package:projeto_despesas_pessoais/components/drawer.dart';
import 'package:projeto_despesas_pessoais/components/transaction_form.dart';
import 'package:projeto_despesas_pessoais/components/transaction_list.dart';

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
  // _selecetedIndex servirá para realizar a alteração do número da categoria apresentada
  int _selectedIndex = 0;

  // Storage é a instância que será usada para realizar as operações com o BD
  final TransactionStorage storage = TransactionStorage();

  // _transactions é a lista das transações cadastradas no mês,
  // a screen funcionará em cima dela
  List<Transaction> _transactions = [];

  // Map das categorias existentes
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
      'icon': const Icon(Icons.more_outlined),
      'color': const Color(0XFFF43460),
      'transactionValue': '4',
    },
  ];

  // O initState para carregar todas as transações do BD
  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  // Traz as transações do BD para a variável _transactions
  void loadTransactions() async {
    final transactions = await storage.getTransactions();
    setState(() {
      _transactions = transactions;
    });
  }

  // Retorna as transações do mês atual
  List<Transaction> get _monthTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(
        DateTime.now().subtract(
          Duration(days: MyUtilityClass.numberDaysMonth),
        ),
      );
    }).toList();
  }

  // double get _totalTransactions {
  //   double sum = 0.0;
  //   for (var tr in _transactions) {
  //     sum += tr.value;
  //   }
  //   return sum;
  // }

  // Função da Bottom Navigation Bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Remove uma trasanção específica da lista _transactions
  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
      storage.saveTransactions(_transactions);
    });
  }

  // Remove todas as transações da lista _transactions
  void _clearTransactions() {
    setState(() {
      _transactions.clear();
    });
    Navigator.of(context).pop();
  }

  // Exibe a caixa de diálogo para confirmar a remoção de todas as transações
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

  // Adiciona uma transação à _transactions
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

  // Mostra a caixa de diálogo em que o formulário de cadastro
  // de transições é exibido
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
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        title: const Text('Minhas Despesas'),
        backgroundColor: color.primary,
        actions: [
          PopupMenuButton(
            color: color.background,
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
                      color: color.secondary,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Limpar todos os gastos',
                      style: text.bodyMedium,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: widget.changeTheme,
                child: Row(
                  children: [
                    Icon(
                      Icons.brightness_4,
                      color: color.secondary,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Alterar tema',
                      style: text.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: color.background,
        child: const MyDrawer(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Chart(
            monthTransactions: _monthTransactions.where((tr) {
              return tr.categoryValue == _selectedIndex.toString();
            }).toList(),
            color: _categoriesMap[_selectedIndex]['color'] as Color,
          ),
          Text('Title Large 123', style: text.titleLarge),
          Text('Title Medium 123', style: text.titleMedium),
          Text('Title Small 123', style: text.titleSmall),
          Text('Body Large 123', style: text.bodyLarge),
          Text('Body Medium 123', style: text.bodyMedium),
          Text('Body Small 123', style: text.bodySmall),
          SizedBox(
            height: 200,
            child: TransactionList(
              transactions: _monthTransactions.where((tr) {
                return tr.categoryValue == _selectedIndex.toString();
              }).toList(),
              color: _categoriesMap[_selectedIndex]['color'] as Color,
              onRemove: _removeTransaction,
            ),
          )
        ],
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
            backgroundColor: color.primary,
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
