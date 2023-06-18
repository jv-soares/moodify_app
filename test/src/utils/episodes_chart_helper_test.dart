import 'package:flutter_test/flutter_test.dart';
import 'package:moodify_app/src/models/episode_severity.dart';
import 'package:moodify_app/src/utils/episodes_chart_helper.dart';

void main() {
  test('should calculate marker positions', () {
    const rowHeight = 10.0;
    expect(
        EpisodesChartHelper.calculateHeight(
            EpisodeSeverity.balanced, rowHeight),
        40);
    expect(
        EpisodesChartHelper.calculateHeight(
            EpisodeSeverity.maniaMild, rowHeight),
        50);
    expect(
        EpisodesChartHelper.calculateHeight(
            EpisodeSeverity.maniaSevere, rowHeight),
        80);
    expect(
        EpisodesChartHelper.calculateHeight(
            EpisodeSeverity.depressionModerateLow, rowHeight),
        20);
    expect(
        EpisodesChartHelper.calculateHeight(
            EpisodeSeverity.depressionSevere, rowHeight),
        0);
  });
}
