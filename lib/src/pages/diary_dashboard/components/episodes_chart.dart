import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import 'package:provider/provider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../../../models/episode_severity.dart';

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
          if (notifier.state is Loading)
            const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          if (notifier.state is Loaded) _Content(widget.rowHeight),
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
  final _scrollController = ScrollController();
  int _indicatorIndex = 0;
  int _indicatorShadowIndex = 0;
  double _itemSize = 0;

  double _calculateItemSize() {
    final screenWidth = MediaQuery.of(context).size.width - 32;
    return screenWidth / 12;
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<DiaryDashboardNotifier>();
    final entries = (notifier.state as Loaded).entries;
    final selectedEntry = notifier.selectedEntry;
    _itemSize = _calculateItemSize();
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          right: _indicatorIndex * _itemSize,
          child: Container(
            height: widget.rowHeight * 9,
            width: _itemSize,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
        ScrollSnapList(
          listController: _scrollController,
          margin: const EdgeInsets.only(right: 16),
          listViewPadding: const EdgeInsets.only(left: 16),
          scrollPhysics: const ClampingScrollPhysics(),
          selectedItemAnchor: SelectedItemAnchor.START,
          onItemFocus: (index) {
            _indicatorShadowIndex = index;
            final entry = entries[index + _indicatorIndex];
            notifier.selectEntry(entry);
          },
          focusOnItemTap: false,
          endOfListTolerance: 0,
          scrollDirection: Axis.horizontal,
          itemCount: entries.length,
          itemSize: _itemSize,
          reverse: true,
          itemBuilder: (context, index) {
            final entry = entries[index];
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (entry.hasDiaryEntry) ...[
                      _buildMarkerFrame(
                        index: index,
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedEntry == entry
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      SizedBox(
                        height:
                            _calculateMarkerPosition(entry.diaryEntry!.episode),
                      ),
                    ],
                    SizedBox(height: widget.rowHeight),
                    _buildMarkerFrame(
                      index: index,
                      child: Text(
                        entry.date.day.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                              color:
                                  selectedEntry == entry ? Colors.white : null,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildMarkerFrame({required Widget child, required int index}) {
    final notifier = context.read<DiaryDashboardNotifier>();
    final entries = (notifier.state as Loaded).entries;
    return GestureDetector(
      onTap: () {
        setState(() {
          notifier.selectEntry(entries[index]);
          _indicatorIndex = index - _indicatorShadowIndex;
        });
      },
      child: SizedBox(
        height: widget.rowHeight,
        width: _itemSize,
        child: Center(child: child),
      ),
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
