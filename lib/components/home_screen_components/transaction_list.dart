import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/components/home_screen_components/transaction_item.dart';
import 'package:projeto_despesas_pessoais/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Color color;
  final String value;
  final void Function(String) onRemove;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.onRemove,
    required this.color,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: FittedBox(
              child: Image.asset(
                'assets/images/empty.png',
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final tr = transactions[index];
              return TransactionItem(
                transaction: tr,
                onRemove: onRemove,
                color: color,
                value: value,
              );
            },
          );
  }
}
