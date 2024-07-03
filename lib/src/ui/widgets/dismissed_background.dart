import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/src/ui/providers/theme_mode_provider.dart';
import 'package:provider/provider.dart';

class DismissedBackground extends StatelessWidget {
  const DismissedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [
          theme.colorScheme.secondary,
          theme.colorScheme.primary,
        ]),
      ),
      child: Container(
        height: 57,
        width: 57,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.8),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Icon(
          Icons.delete,
          color: Provider.of<ThemeModeProvider>(context).darkThemeIsOn ? Colors.white : Colors.red,
          size: 25,
        ),
      ),
    );
  }
}
