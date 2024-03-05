import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/components/home_screen_components/chart.dart';
import 'package:projeto_despesas_pessoais/components/home_screen_components/drawer.dart';
import 'package:projeto_despesas_pessoais/models/transaction.dart';
import 'package:projeto_despesas_pessoais/providers/transactions_list_provider.dart';
import 'package:projeto_despesas_pessoais/utils/app_utils.dart';
import 'package:provider/provider.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions =
        Provider.of<TransactionsListProvider>(context).monthTransactions;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Estatísticas Gerais'),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: const MyDrawer(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(MyUtilityClass.monthAndYear,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 10),
              Chart(
                transactions: transactions,
                color: Theme.of(context).colorScheme.secondary,
              ),
              CategoryItem(
                transactionsCategory: transactions
                    .where((tr) => tr.categoryValue == '0')
                    .toList(),
                title: 'Alimentos',
                icon: Icons.restaurant,
                color: const Color(0XFFF8AB02),
              ),
              CategoryItem(
                transactionsCategory: transactions
                    .where((tr) => tr.categoryValue == '1')
                    .toList(),
                title: 'Faturas',
                icon: Icons.attach_money,
                color: const Color(0XFF01D99F),
              ),
              CategoryItem(
                transactionsCategory: transactions
                    .where((tr) => tr.categoryValue == '2')
                    .toList(),
                title: 'Transporte',
                icon: Icons.directions_bus_rounded,
                color: const Color(0XFF36B5EB),
              ),
              CategoryItem(
                transactionsCategory: transactions
                    .where((tr) => tr.categoryValue == '3')
                    .toList(),
                title: 'Moradia',
                icon: Icons.house_rounded,
                color: const Color(0XFF897AF1),
              ),
              CategoryItem(
                transactionsCategory: transactions
                    .where((tr) => tr.categoryValue == '4')
                    .toList(),
                title: 'Outros',
                icon: Icons.more_horiz_outlined,
                color: const Color(0XFFF43460),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<Transaction> transactionsCategory;

  const CategoryItem({
    super.key,
    required this.transactionsCategory,
    required this.title,
    required this.icon,
    required this.color,
  });

  double get totalValue {
    return transactionsCategory.fold(0.0, (sum, tr) => sum + tr.value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Icon(icon, color: color),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Text('R\$ ${totalValue.toStringAsFixed(2)}'),
            ],
          ),
        ],
      ),
    );
  }
}
