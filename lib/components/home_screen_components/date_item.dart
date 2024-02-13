import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateItem extends StatelessWidget {
  const DateItem({super.key});

  // Rertorna o nome do mês atual
  String get monthAndYear {
    DateTime currentDate = DateTime.now();
    String currentMonthAndYear =
        DateFormat('MMMM, y', 'pt_BR').format(currentDate);

    String dateFormated =
        currentMonthAndYear[0].toUpperCase() + currentMonthAndYear.substring(1);

    return dateFormated;
  }

  List<Map<String, Object>> get days {
    final prevDays = List.generate(
        3, (index) => DateTime.now().subtract(Duration(days: index + 1)));
    final nextDays = List.generate(
        3, (index) => DateTime.now().add(Duration(days: index + 1)));

    return [...prevDays.reversed, DateTime.now(), ...nextDays].map((day) {
      return {
        'weekDay': DateFormat('E', 'pt_BR').format(day),
        'day': day.day,
      };
    }).toList();
  }

  bool sameDay(int day) {
    return DateTime.now().day == day;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          monthAndYear,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...days.map(
              (day) {
                return Column(
                  children: [
                    Text(
                      "${day['weekDay']}",
                      style: TextStyle(
                        fontFamily: 'Gabarito',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: sameDay(day['day'] as int) ? null : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${day['day']}",
                      style: TextStyle(
                        color: sameDay(day['day'] as int) ? null : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 2),
                    if (sameDay(day['day'] as int))
                      Container(
                        height: 5,
                        width: 5,
                        decoration: const BoxDecoration(
                          color: Color(0XFF22B584),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
