class DateTimeFiller {
  static List<DateTime> fillGaps(List<DateTime> list) {
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
}
