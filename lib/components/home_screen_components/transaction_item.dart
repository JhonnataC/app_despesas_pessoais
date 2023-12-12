import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction tr;
  final Color color;
  final void Function(String p1) onRemove;

  const TransactionItem({
    super.key,
    required this.tr,
    required this.onRemove,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: color,
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
          style: const TextStyle(
            fontFamily: 'Gabarito',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          DateFormat("d MMMM',' yyyy", 'pt_BR').format(tr.date),
          style: const TextStyle(
            fontFamily: 'Gabarito',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 450
            ? TextButton(
                onPressed: () => onRemove(tr.id),
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Excluir',
                  style: TextStyle(
                    fontFamily: 'Gabarito',
                  ),
                ),
              )
            : IconButton(
                onPressed: () => onRemove(tr.id),
                icon: const Icon(Icons.delete),
                color: Colors.white,
              ),
      ),
    );
  }
}
