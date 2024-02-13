import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/models/transaction.dart';
import 'package:projeto_despesas_pessoais/utils/app_utils.dart';
import 'package:projeto_despesas_pessoais/components/home_screen_components/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> monthTransactionsInCategory;
  final Color color;

  const Chart({
    super.key,
    required this.monthTransactionsInCategory,
    required this.color,
  });

  List<Map<String, dynamic>> get groupedTransactions {
    return List.generate(MyUtilityClass.numberDaysMonth, (index) {
      var dateAux =
          DateTime.now().subtract(Duration(days: DateTime.now().day - 1));

      final monthDay = dateAux.add(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < monthTransactionsInCategory.length; i++) {
        bool sameDay = monthTransactionsInCategory[i].date.day == monthDay.day;
        bool sameMonth =
            monthTransactionsInCategory[i].date.month == monthDay.month;
        bool sameYear =
            monthTransactionsInCategory[i].date.year == monthDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += monthTransactionsInCategory[i].value;
        }
      }

      return {
        'day': monthDay.day,
        'value': totalSum,
      };
    }).toList();
  }

  // Retorna o gasto total do mes
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
                      color: color,
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
