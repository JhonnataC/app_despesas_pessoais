import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/utils/app_routes.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  Widget _createItem(
      BuildContext context, IconData icon, String title, Function() onTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/drawer_bg.png'),
        _createItem(
          context,
          Icons.home_rounded,
          'Início',
          () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME_SCREEN),
        ),
        _createItem(
          context,
          Icons.bar_chart_rounded,
          'Estatísticas Gerais',
          () => Navigator.of(context)
              .pushReplacementNamed(AppRoutes.STATISTICS_SCREEN),
        ),
        _createItem(
          context,
          Icons.history,
          'Histórico',
          () => Navigator.of(context)
              .pushReplacementNamed(AppRoutes.HISTORY_SCREEN),
        ),
        // _createItem(
        //   context,
        //   Icons.show_chart_outlined,
        //   'Gráficos',
        //   () => Navigator.of(context).pushNamed(AppRoutes.GRAPHICS_SCREEN),
        // ),
      ],
    );
  }
}
