import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

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
    final adjustedFrom = DateTime(from.year, from.month, from.day);
    final adjustedTo = DateTime(to.year, to.month, to.day);
    final length = adjustedTo.difference(adjustedFrom).inDays.abs() + 1;
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
    return DateUtils.isSameDay(a, b);
  }

  static List<TimeOfDay> sortTimeOfDayList(List<TimeOfDay> list) {
    return list.sorted((a, b) {
      final result = a.hour.compareTo(b.hour);
      if (result == 0) return a.minute.compareTo(b.minute);
      return result;
    });
  }
}

extension DateTimeX on DateTime {
  bool isBetween(DateTime start, DateTime end) {
    final startMicroseconds = start.microsecondsSinceEpoch;
    final endMicroseconds =
        end.microsecondsSinceEpoch + const Duration(hours: 23).inMicroseconds;
    return microsecondsSinceEpoch >= startMicroseconds &&
        microsecondsSinceEpoch <= endMicroseconds;
  }

  bool isSameDayMonthAndYear(DateTime other) {
    return DateTimeUtils.compareDayOfYear(this, other);
  }
}
