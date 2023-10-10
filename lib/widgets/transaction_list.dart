import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/models/transaction.dart';
import 'package:projeto_despesas_pessoais/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Color color;
  final void Function(String) onRemove;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.onRemove,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.5,
                    child: LayoutBuilder(
                      builder: (ctx, constraints) {
                        return Icon(
                          Icons.playlist_add_check_circle_sharp,
                          size: constraints.maxHeight * 0.85,
                          color: color,
                        );
                      },
                    ),
                  ),
                  Text(
                    'Sem gastos até o momento nesta categoria',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final tr = transactions[index];
              return TransactionItem(
                tr: tr,
                onRemove: onRemove,
                color: color,
              );
            },
          );
  }
}
