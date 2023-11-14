import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_despesas_pessoais/models/transaction.dart';
import 'package:projeto_despesas_pessoais/utils/app_utils.dart';
import 'package:projeto_despesas_pessoais/components/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> monthTransactions;
  final Color color;

  const Chart({
    super.key,
    required this.monthTransactions,
    required this.color,
  });

  // Rertorna o nome do mes atual
  String get month {
    DateTime currentDate = DateTime.now();
    String currentMonth = DateFormat('MMMM', 'pt_BR').format(currentDate);

    String monthFormated =
        currentMonth[0].toUpperCase() + currentMonth.substring(1);

    return monthFormated;
  }

  List<Map<String, dynamic>> get groupedTransactions {
    return List.generate(MyUtilityClass.numberDaysMonth, (index) {
      final monthDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < monthTransactions.length; i++) {
        bool sameDay = monthTransactions[i].date.day == monthDay.day;
        bool sameMonth = monthTransactions[i].date.month == monthDay.month;
        bool sameYear = monthTransactions[i].date.year == monthDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += monthTransactions[i].value;
        }
      }

      return {
        'day': (index + 1),
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
    return SizedBox(
      child: Column(
        children: [
          Text(
            month,
            style: Theme.of(context).textTheme.titleMedium,
          ),
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
                      height: 150, // responsitividade
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
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
