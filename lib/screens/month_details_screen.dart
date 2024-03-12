import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_despesas_pessoais/components/home_screen_components/chart_bar.dart';

class MonthDetailsScreen extends StatelessWidget {
  const MonthDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(data['date']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HistoryChart(transactions: data['transactions']),
            SizedBox(
              height:500,
              child: HistoryTransactionList(transactions: data['transactions']),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryChart extends StatelessWidget {
  final List<dynamic> transactions;

  const HistoryChart({super.key, required this.transactions});

  int daysInMonth(int month, int year) {
    final lastDayOfMonth = DateTime(year, month + 1, 0);
    return lastDayOfMonth.day;
  }

  List<Map<String, dynamic>> get groupedTransactions {
    final date = transactions.first.date;

    return List.generate(daysInMonth(date.month, date.year), (index) {
      var dateAux = date.subtract(Duration(days: date.day - 1));

      final monthDay = dateAux.add(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < transactions.length; i++) {
        bool sameDay = transactions[i].date.day == monthDay.day;
        bool sameMonth = transactions[i].date.month == monthDay.month;
        bool sameYear = transactions[i].date.year == monthDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += transactions[i].value;
        }
      }

      return {
        'day': monthDay.day,
        'value': totalSum,
      };
    }).toList();
  }

  double get _monthTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + tr['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.only(right: 5, left: 5, top: 10),
      child: Column(
        children: [
          Row(
            children: [
              FittedBox(
                  child: Text(
                'R\$ ${_monthTotalValue.truncate()}',
                style: Theme.of(context).textTheme.bodySmall,
              )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      width: 2,
                      height: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).colorScheme.secondary,
                            Theme.of(context).colorScheme.primary,
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                const SizedBox(width: 5),
                ...groupedTransactions.map((tr) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: tr['day'].toString(),
                      color: Theme.of(context).colorScheme.primary,
                      percentage: _monthTotalValue == 0
                          ? 0
                          : tr['value'] / _monthTotalValue,
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryTransactionList extends StatelessWidget {
  final List<dynamic> transactions;

  const HistoryTransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Container(
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
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.monetization_on_outlined, color: Colors.white),
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
          );
        });
  }
}
