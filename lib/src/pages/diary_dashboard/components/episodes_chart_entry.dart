import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../../../models/episode_severity.dart';

class EpisodesChart extends StatefulWidget {
  final List<EpisodesChartEntry> episodes;
  final double rowHeight;

  const EpisodesChart({
    super.key,
    required this.episodes,
    this.rowHeight = 28,
  });

  @override
  State<EpisodesChart> createState() => _EpisodesChartState();
}

class _EpisodesChartState extends State<EpisodesChart> {
  late List<EpisodesChartEntry> _sortedEpisodes;
  late EpisodesChartEntry _selectedEpisode;

  @override
  void initState() {
    super.initState();
    _sortedEpisodes = _getSortedEpisodes();
    _selectedEpisode = _sortedEpisodes.first;
  }

  @override
  void didUpdateWidget(covariant EpisodesChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sortedEpisodes = _getSortedEpisodes();
  }

  List<EpisodesChartEntry> _getSortedEpisodes() {
    return widget.episodes.sortedByCompare(
      (e) => e.createdAt,
      (a, b) => b.compareTo(a),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.rowHeight * 9,
      color: Colors.green.shade100,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: widget.rowHeight / 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                4,
                (index) => Container(
                  margin: EdgeInsets.symmetric(vertical: widget.rowHeight / 2),
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  height: widget.rowHeight,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 32,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: ScrollSnapList(
              listViewPadding: EdgeInsets.zero,
              onItemFocus: (index) {
                setState(() => _selectedEpisode = _sortedEpisodes[index]);
              },
              scrollDirection: Axis.horizontal,
              itemCount: widget.episodes.length,
              itemSize: 32,
              reverse: true,
              itemBuilder: (context, index) {
                final item = _sortedEpisodes[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildMarkerFrame(
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _selectedEpisode == item
                              ? Colors.white
                              : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    SizedBox(height: _calculateMarkerPosition(item.episode)),
                    SizedBox(height: widget.rowHeight),
                    _buildMarkerFrame(
                      child: Text(
                        item.createdAt.day.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                color: _selectedEpisode == item
                                    ? Colors.white
                                    : null),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkerFrame({required Widget child}) {
    final verticalMargin = (widget.rowHeight - 16) / 2;
    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalMargin, horizontal: 8),
      child: child,
    );
  }

  double _calculateMarkerPosition(EpisodeSeverity episode) {
    if (episode is Mania) {
      return episode.level.value * widget.rowHeight;
    } else if (episode is Depression) {
      return episode.level.value * widget.rowHeight;
    }
    return 0;
  }
}

class EpisodesChartEntry {
  final EpisodeSeverity episode;
  final DateTime createdAt;

  EpisodesChartEntry(this.episode, this.createdAt);
}
