import 'package:flutter/material.dart';

class ConfirmBox extends StatelessWidget {
  final int typeMessage;
  final Function onPressed;

  const ConfirmBox({
    super.key,
    required this.typeMessage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final String message;

    if (typeMessage == 1) {
      message = 'Deseja apagar todos os gastos cadastrados?';
    } else {
      message = 'Deseja limpar o histórico?';
    }

    return AlertDialog(
      titleTextStyle: Theme.of(context).textTheme.titleMedium,
      contentTextStyle: Theme.of(context).textTheme.bodyMedium,
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      title: const Text('Confirme!'),
      content: Text(message),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.bodySmall,
            foregroundColor: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            onPressed();
            Navigator.of(context).pop();
          },
          child: const Text('Sim'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.bodySmall,
            foregroundColor: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
