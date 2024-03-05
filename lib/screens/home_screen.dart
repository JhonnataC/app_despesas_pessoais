import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/components/home_screen_components/confirm_box.dart';
import 'package:projeto_despesas_pessoais/components/home_screen_components/date_item.dart';
import 'package:projeto_despesas_pessoais/providers/categories_map_provider.dart';
import 'package:projeto_despesas_pessoais/components/home_screen_components/chart.dart';
import 'package:projeto_despesas_pessoais/components/home_screen_components/drawer.dart';
import 'package:projeto_despesas_pessoais/components/home_screen_components/transaction_form.dart';
import 'package:projeto_despesas_pessoais/components/home_screen_components/transaction_list.dart';
import 'package:projeto_despesas_pessoais/providers/transactions_list_provider.dart';
import 'package:provider/provider.dart';

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

  // Função da Bottom Navigation Bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Exibe a caixa de diálogo para confirmar a remoção de todas as transações
  void _showConfirmBox(Function() clearTransactions) {
    Future.delayed(
      Duration.zero,
      () {
        showDialog(
          context: context,
          builder: (_) {
            return ConfirmBox(typeMessage: 1, onPressed: clearTransactions);
          },
        );
      },
    );
  }

  // Mostra a caixa de diálogo em que o formulário de cadastro
  // de transições é exibido
  void _openTrasactionFormModal(BuildContext context,
      Function(String, double, DateTime, String) addTransaction) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: TransactionForm(
              onSubmit: addTransaction,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          surfaceTintColor: Theme.of(context).colorScheme.background,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<TransactionsListProvider>(context).loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final categories =
        Provider.of<CategoriesMapProvider>(context).categoriesMap;
    final transactionsProvider = Provider.of<TransactionsListProvider>(context);

    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        title: const Text('Minhas Despesas'),
        actions: [
          PopupMenuButton(
            color: color.background,
            icon: const Icon(
              Icons.settings,
              color: Color(0XFFE0E3E8),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () =>
                    _showConfirmBox(transactionsProvider.clearTransactions),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const DateItem(),
            const SizedBox(height: 30),
            Chart(
              transactions: transactionsProvider.monthTransactions.where((tr) {
                return tr.categoryValue == _selectedIndex.toString();
              }).toList(),
              color: categories[_selectedIndex]['color'] as Color,
            ),
            SizedBox(
              height: 400,
              child: TransactionList(
                transactions: transactionsProvider.transactions.where((tr) {
                  return tr.categoryValue == _selectedIndex.toString();
                }).toList(),
                color: categories[_selectedIndex]['color'] as Color,
                value: categories[_selectedIndex]['transactionValue'] as String,
                onRemove: transactionsProvider.removeTransaction,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: categories[_selectedIndex]['color'] as Color,
        onPressed: () => _openTrasactionFormModal(
          context,
          transactionsProvider.addTransaction,
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: categories.map((category) {
          return BottomNavigationBarItem(
            label: category['title'] as String,
            icon: category['icon'] as Widget,
            backgroundColor: color.primary,
          );
        }).toList(),
        selectedItemColor: categories[_selectedIndex]['color'] as Color,
        unselectedItemColor: const Color(0XFFE0E3E8),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
