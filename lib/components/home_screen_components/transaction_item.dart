import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_despesas_pessoais/components/home_screen_components/dismissed_background.dart';

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
        return Icons.directions_bus_rounded;
      case '3':
        return Icons.house;
      case '4':
        return Icons.more_horiz_outlined;
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
        padding: const EdgeInsets.only(right: 8),
        child: const DismissedBackground(),
      ),
      onDismissed: (_) => onRemove(transaction.id),
      child: Container(
        decoration: BoxDecoration(
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
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 7),
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 0.1,
                    blurRadius: 4,
                    offset: Offset(2, 1),
                  ),
                ]),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: color,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(icon),
              ),
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
