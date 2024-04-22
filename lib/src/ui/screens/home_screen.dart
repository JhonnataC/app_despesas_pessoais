import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/src/ui/widgets/confirm_box.dart';
import 'package:projeto_despesas_pessoais/src/ui/widgets/date_item.dart';
import 'package:projeto_despesas_pessoais/src/ui/widgets/notification_settings.dart';
import 'package:projeto_despesas_pessoais/src/ui/providers/categories_map_provider.dart';
import 'package:projeto_despesas_pessoais/src/ui/widgets/chart.dart';
import 'package:projeto_despesas_pessoais/src/ui/widgets/drawer.dart';
import 'package:projeto_despesas_pessoais/src/ui/widgets/transaction_form.dart';
import 'package:projeto_despesas_pessoais/src/ui/widgets/transaction_list.dart';
import 'package:projeto_despesas_pessoais/src/ui/providers/intro_screen_provider.dart';
import 'package:projeto_despesas_pessoais/src/ui/providers/notifications_provider.dart';
import 'package:projeto_despesas_pessoais/src/ui/providers/theme_mode_provider.dart';
import 'package:projeto_despesas_pessoais/src/ui/providers/transactions_list_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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

  void _showNotificationSettings() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const NotificationSettings(),
          backgroundColor: Theme.of(context).colorScheme.background,
          surfaceTintColor: Theme.of(context).colorScheme.background,
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
          content: TransactionForm(
            onSubmit: addTransaction,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          surfaceTintColor: Theme.of(context).colorScheme.background,
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<IntroScreenProvider>(context, listen: false)
        .turnOffIntroScreen();
    Provider.of<TransactionsListProvider>(context).loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final categories =
        Provider.of<CategoriesMapProvider>(context).categoriesMap;
    final transactionsProvider = Provider.of<TransactionsListProvider>(context);
    final ntProvider = Provider.of<NotificationsProvider>(context);
    final tmProvider = Provider.of<ThemeModeProvider>(context);

    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        title: const Text('Minhas Despesas'),
        actions: [
          PopupMenuButton(
            color: color.background,
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Color(0XFFFFFFFF),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () =>
                    _showConfirmBox(transactionsProvider.clearTransactions),
                child: Row(
                  children: [
                    Icon(
                      Icons.clear_all_rounded,
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
                onTap: () {
                  tmProvider.changeTheme();
                },
                child: Row(
                  children: [
                    Icon(
                      tmProvider.darkThemeIsOn
                          ? Icons.nights_stay_outlined
                          : Icons.wb_sunny,
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
              PopupMenuItem(
                onTap: _showNotificationSettings,
                child: Row(
                  children: [
                    Icon(
                      ntProvider.notificationIsOn
                          ? Icons.notifications_active_rounded
                          : Icons.notifications_off_rounded,
                      color: color.secondary,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Notificações',
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
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          items: categories.map((category) {
            return BottomNavigationBarItem(
              label: category['title'] as String,
              icon: category['icon'] as Widget,
            );
          }).toList(),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedFontSize: 12,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
        ),
      ),
    );
  }
}