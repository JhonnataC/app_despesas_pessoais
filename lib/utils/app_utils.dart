class MyUtilityClass {
  static int get numberDaysMonth {
    DateTime firstDayNextMonth =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 1);
    DateTime lastDayCurrentMonth =
        firstDayNextMonth.subtract(const Duration(days: 1));
    int days = lastDayCurrentMonth.day;
    return days;
  }
}
