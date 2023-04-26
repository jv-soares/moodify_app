import 'package:flutter_test/flutter_test.dart';
import 'package:moodify_app/src/models/episode_severity.dart';
import 'package:moodify_app/src/utils/episodes_chart_helper.dart';

void main() {
  test('should calculate marker positions', () {
    const rowHeight = 10.0;
    expect(EpisodesChartHelper.calculateHeight(Balanced(), rowHeight), 40);
    expect(
      EpisodesChartHelper.calculateHeight(Mania(Level.mild), rowHeight),
      50,
    );
    expect(
      EpisodesChartHelper.calculateHeight(Mania(Level.severe), rowHeight),
      80,
    );
    expect(
      EpisodesChartHelper.calculateHeight(
          Depression(Level.moderateLow), rowHeight),
      20,
    );
    expect(
      EpisodesChartHelper.calculateHeight(Depression(Level.severe), rowHeight),
      0,
    );
  });
}
