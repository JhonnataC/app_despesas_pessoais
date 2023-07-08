import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_despesas_pessoais/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 650,
      child: transactions.isEmpty
          ? Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  height: 200,
                  child: Icon(
                    Icons.playlist_add_check_circle_sharp,
                    size: 200,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Sem gastos até o momento',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tr = transactions[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FittedBox(
                          child: Text(
                            '\$${tr.value}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      DateFormat("d MMMM',' yyyy", 'pt_BR').format(tr.date),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    trailing: IconButton(
                      onPressed: () => onRemove(tr.id),
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
