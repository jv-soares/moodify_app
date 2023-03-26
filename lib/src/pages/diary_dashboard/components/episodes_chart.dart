import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import 'package:provider/provider.dart';

import '../../../models/episode_severity.dart';
import 'my_snap_list.dart';

class EpisodesChart extends StatefulWidget {
  final double rowHeight;

  const EpisodesChart({
    super.key,
    this.rowHeight = 28,
  });

  @override
  State<EpisodesChart> createState() => _EpisodesChartState();
}

class _EpisodesChartState extends State<EpisodesChart> {
  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<DiaryDashboardNotifier>();
    return SizedBox(
      height: widget.rowHeight * 9,
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
          if (notifier.dashboardState is Loading)
            const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          if (notifier.dashboardState is Loaded) _Content(widget.rowHeight),
        ],
      ),
    );
  }
}

class _Content extends StatefulWidget {
  final double rowHeight;

  const _Content(this.rowHeight);

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<DiaryDashboardNotifier>();
    final entries = (notifier.dashboardState as Loaded).entries;
    final selectedEntry = notifier.selectedEntry;
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 150),
          right: _selectedIndex * 32,
          child: Container(
            height: widget.rowHeight * 9,
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
          child: MyScrollSnapList(
            scrollPhysics: const ClampingScrollPhysics(),
            selectedItemAnchor: SelectedItemAnchor.START,
            listViewPadding: EdgeInsets.zero,
            onItemFocus: (index) {
              setState(() => _selectedIndex = index);
              notifier.selectEntry(entries[index]);
            },
            scrollDirection: Axis.horizontal,
            itemCount: entries.length,
            itemSize: 32,
            reverse: true,
            itemBuilder: (context, index) {
              final item = entries[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildMarkerFrame(
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedEntry == item
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
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: selectedEntry == item ? Colors.white : null),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
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