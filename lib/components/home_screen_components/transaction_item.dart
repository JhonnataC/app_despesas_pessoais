import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/transaction.dart';

// ignore: must_be_immutable
class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Color color;
  final String value;
  final void Function(String p1) onRemove;

  const TransactionItem({
    super.key,
    required this.transaction,
    required this.onRemove,
    required this.color,
    required this.value,
  });

  IconData? get icon {
    switch (value) {
      case '0':
        return Icons.restaurant;
      case '1':
        return Icons.attach_money;
      case '2':
        return Icons.emoji_transportation;
      case '3':
        return Icons.house;
      case '4':
        return Icons.other_houses_rounded;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(transaction.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (_) => onRemove(transaction.id),
      child: Container(
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
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(icon),
            ),
          ),
          title: Text(
            transaction.title,
            style: const TextStyle(
              fontFamily: 'Gabarito',
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            DateFormat("d MMMM',' yyyy", 'pt_BR').format(transaction.date),
            style: const TextStyle(
              fontFamily: 'Gabarito',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          trailing: Text(
            'R\$ ${transaction.value.toStringAsFixed(2)}',
            style: const TextStyle(
              fontFamily: 'Gabarito',
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
