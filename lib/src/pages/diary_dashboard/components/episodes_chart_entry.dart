import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../models/episode_severity.dart';

class EpisodesChart extends StatelessWidget {
  final List<EpisodesChartEntry> episodes;
  final double rowHeight;

  const EpisodesChart({
    super.key,
    required this.episodes,
    this.rowHeight = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade100,
      child: Stack(
        children: [
          Padding(
            key: key,
            padding: EdgeInsets.symmetric(vertical: rowHeight / 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                4,
                (index) => Container(
                  margin: EdgeInsets.symmetric(vertical: rowHeight / 2),
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  height: rowHeight,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Row(
                textDirection: TextDirection.rtl,
                children: episodes
                    .sortedByCompare(
                        (e) => e.createdAt, (a, b) => b.compareTo(a))
                    .map((e) {
                  return Container(
                    height: rowHeight * (episodes.length - 1),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildMarkerFrame(
                          child: Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        SizedBox(height: _calculateMarkerPosition(e.episode)),
                        SizedBox(height: rowHeight),
                        _buildMarkerFrame(
                          child: Text(
                            e.createdAt.day.toString(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkerFrame({required Widget child}) {
    final verticalMargin = (rowHeight - 16) / 2;
    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalMargin, horizontal: 8),
      child: child,
    );
  }

  double _calculateMarkerPosition(EpisodeSeverity episode) {
    if (episode is Mania) {
      return episode.level.value * rowHeight;
    } else if (episode is Depression) {
      return episode.level.value * rowHeight;
    }
    return 0;
  }
}

class EpisodesChartEntry {
  final EpisodeSeverity episode;
  final DateTime createdAt;

  EpisodesChartEntry(this.episode, this.createdAt);
}
