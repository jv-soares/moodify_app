import 'package:flutter_test/flutter_test.dart';
import 'package:moodify_app/src/utils/date_time_filler.dart';

void main() {
  test('should fill date time gaps', () {
    final incompleteDates = [
      DateTime(2022, 1, 1),
      DateTime(2022, 1, 2),
      DateTime(2022, 1, 4),
      DateTime(2022, 1, 5),
      DateTime(2022, 1, 8),
    ];
    final dates = DateTimeFiller.fillGaps(incompleteDates);
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
}
