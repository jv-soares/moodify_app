abstract class DateTimeUtils {
  static List<DateTime> fillListGaps(List<DateTime> list) {
    final resultList = <DateTime>[];
    for (var i = 0; i < list.length - 1; i++) {
      resultList.add(list[i]);
      final distance = list[i + 1].difference(list[i]);
      if (distance.inDays > 1) {
        for (var j = 0; j < distance.inDays - 1; j++) {
          resultList.add(list[i].add(Duration(days: j + 1)));
        }
      }
    }
    return resultList..add(list.last);
  }

  static List<DateTime> generateList(DateTime from, DateTime to) {
    final length = to.difference(from).inDays.abs() + 1;
    if (to.isAfter(from)) {
      return List.generate(
        length,
        (index) => from.add(Duration(days: index)),
      );
    } else {
      return List.generate(
        length,
        (index) => from.subtract(Duration(days: index)),
      );
    }
  }

  static bool compareDayOfYear(DateTime a, DateTime b) {
    final isDayEqual = a.day == b.day;
    final isMonthEqual = a.month == b.month;
    final isYearEqual = a.year == b.year;
    return isDayEqual && isMonthEqual && isYearEqual;
  }
}
