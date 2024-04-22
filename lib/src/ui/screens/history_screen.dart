import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/src/ui/widgets/confirm_box.dart';
import 'package:projeto_despesas_pessoais/src/ui/widgets/drawer.dart';
import 'package:projeto_despesas_pessoais/src/ui/providers/transactions_historic_provider.dart';
import 'package:projeto_despesas_pessoais/src/data/utils/app_routes.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<TransactionsHistoryProvider>(context).loadTransactionsHistory();
  }

  void _showConfirmBox(Function() clearHistory) {
    Future.delayed(
      Duration.zero,
      () {
        showDialog(
          context: context,
          builder: (_) {
            return ConfirmBox(typeMessage: 2, onPressed: clearHistory);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<TransactionsHistoryProvider>(context);

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text('Histórico'),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                    onTap: () => _showConfirmBox(
                        () => historyProvider.clearTransactionsHistory()),
                    child: Row(
                      children: [
                        Icon(
                          Icons.clear_all_rounded,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Limpar Histórico',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.background,
          child: const MyDrawer(),
        ),
        body: historyProvider.history.isEmpty
            ? Center(
                child: Image.asset(
                  'assets/images/history_empty.png',
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              )
            : SingleChildScrollView(
                child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: historyProvider.history.length,
                  itemBuilder: (context, index) {
                    
                    String date = historyProvider.history[index]['date'];
                    String dateFormated =
                        date[0].toUpperCase() + date.substring(1);

                    return InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        final arguments = {
                          'date': dateFormated,
                          'transactions': historyProvider.history[index]
                              ['transactions'],
                        };
                        Navigator.of(context).pushNamed(
                            AppRoutes.MONTH_DETAILS_SCREEN,
                            arguments: arguments);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8),
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: const Icon(Icons.calendar_month_sharp,
                                color: Colors.white),
                          ),
                          title: Text(
                            dateFormated,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )));
  }
}
