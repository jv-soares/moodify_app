import 'package:flutter_test/flutter_test.dart';
import 'package:moodify_app/src/utils/date_time_utils.dart';

void main() {
  test('should fill date time gaps', () {
    final incompleteDates = [
      DateTime(2022, 1, 1),
      DateTime(2022, 1, 2),
      DateTime(2022, 1, 4),
      DateTime(2022, 1, 5),
      DateTime(2022, 1, 8),
    ];
    final dates = DateTimeUtils.fillListGaps(incompleteDates);
    expect(dates, [
      DateTime(2022, 1, 1),
      DateTime(2022, 1, 2),
      DateTime(2022, 1, 3),
      DateTime(2022, 1, 4),
      DateTime(2022, 1, 5),
      DateTime(2022, 1, 6),
      DateTime(2022, 1, 7),
      DateTime(2022, 1, 8),
    ]);
  });

  test('should compare day of year', () {
    final a = DateTime(2022, 2, 11, 9, 30);
    final b = DateTime(2022, 2, 11, 2, 15);
    expect(DateTimeUtils.compareDayOfYear(a, b), isTrue);

    final c = DateTime(2022, 4, 11, 9, 30);
    final d = DateTime(2022, 2, 11, 9, 30);
    expect(DateTimeUtils.compareDayOfYear(c, d), isFalse);
  });

  test('should generate date time list', () {
    final list = DateTimeUtils.generateList(
      DateTime(2022, 1, 1),
      DateTime(2022, 1, 5),
    );
    expect(list, [
      DateTime(2022, 1, 1),
      DateTime(2022, 1, 2),
      DateTime(2022, 1, 3),
      DateTime(2022, 1, 4),
      DateTime(2022, 1, 5),
    ]);
    final list2 = DateTimeUtils.generateList(
      DateTime(2022, 1, 5),
      DateTime(2022, 1, 1),
    );
    expect(list2, [
      DateTime(2022, 1, 5),
      DateTime(2022, 1, 4),
      DateTime(2022, 1, 3),
      DateTime(2022, 1, 2),
      DateTime(2022, 1, 1),
    ]);
  });

  test('should check whether date interval contains date', () {
    var date = DateTime(2022, 2, 15);
    var from = DateTime(2022, 1);
    var to = DateTime(2022, 3);
    expect(date.isBetween(from, to), isTrue);

    from = DateTime(2022, 2, 15);
    expect(date.isBetween(from, to), isTrue);

    to = DateTime(2022, 2, 15);
    expect(date.isBetween(from, to), isTrue);

    date = DateTime(2022, 2, 16);
    expect(date.isBetween(from, to), isFalse);
  });
}
