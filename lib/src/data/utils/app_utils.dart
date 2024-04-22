import 'package:intl/intl.dart';

class MyUtilityClass {
  static int get numberDaysMonth {
    DateTime firstDayNextMonth =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 1);
    DateTime lastDayCurrentMonth =
        firstDayNextMonth.subtract(const Duration(days: 1));
    int days = lastDayCurrentMonth.day;
    return days;
  }

  static String get monthAndYear {
    DateTime currentDate = DateTime.now();
    String currentMonthAndYear =
        DateFormat('MMMM, y', 'pt_BR').format(currentDate);

    String dateFormated =
        currentMonthAndYear[0].toUpperCase() + currentMonthAndYear.substring(1);

    return dateFormated;
  }
}