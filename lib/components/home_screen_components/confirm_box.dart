import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/providers/transactions_list_provider.dart';
import 'package:provider/provider.dart';

class ConfirmBox extends StatelessWidget {
  const ConfirmBox({super.key});

  @override
  Widget build(BuildContext context) {
    var transactionsProvider = Provider.of<TransactionsListProvider>(context);

    return AlertDialog(
      titleTextStyle: Theme.of(context).textTheme.titleMedium,
      contentTextStyle: Theme.of(context).textTheme.bodyMedium,
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      title: const Text('Confirme!'),
      content: const Text(
          'Tem certeza que quer apagar todos os gastos cadastrados?'),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.bodySmall,
            foregroundColor: const Color(0XFF6365EE),
          ),
          onPressed: () {
            transactionsProvider.clearTransactions();
            Navigator.of(context).pop();
          },
          child: const Text('Sim'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.bodySmall,
            foregroundColor: const Color(0XFF6365EE),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
