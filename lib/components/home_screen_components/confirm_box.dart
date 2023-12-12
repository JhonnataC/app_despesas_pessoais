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
      title: const Text('Confirmação'),
      content: const Text(
          'Atenção: tem certeza que quer apagar todos os gastos cadastrados?'),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: Theme.of(context).textTheme.bodySmall,
            backgroundColor: Theme.of(context).colorScheme.background,
            foregroundColor: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () {
            transactionsProvider.clearTransactions();
            Navigator.of(context).pop();
          },
          child: const Text('Sim'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: Theme.of(context).textTheme.bodySmall,
            backgroundColor: Theme.of(context).colorScheme.background,
            foregroundColor: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
