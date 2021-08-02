import 'package:state_management_clean_arch/app/constants.dart';

class DateUtil {
  static List<DateTime> get next7Days {
    List<DateTime> oneWeekDateTimes = [
      DateTime.now(),
    ];
    for (int i = 1; i < 7; i++) {
      oneWeekDateTimes.add(
        DateTime.now().add(
          Duration(days: i),
        ),
      );
    }
    return oneWeekDateTimes;
  }

  static String getDayOfGivenDateTime(DateTime date) {
    return daysOfWeek[date.weekday - 1];
  }

  static String getMonthOFGivenDateTime(DateTime date) {
    return monthsOfYear[date.month - 1];
  }
}
