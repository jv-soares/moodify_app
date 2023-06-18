import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import 'package:moodify_app/src/utils/episodes_chart_helper.dart';
import 'package:moodify_app/src/utils/list_extension.dart';
import 'package:provider/provider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../../../models/episode_severity.dart';

class EpisodesChart extends StatelessWidget {
  final double rowHeight;

  const EpisodesChart({
    super.key,
    this.rowHeight = 28,
  });

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<DiaryDashboardNotifier>();
    return SizedBox(
      height: rowHeight * 11,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: rowHeight),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List<Widget>.generate(
                5,
                (index) => _buildHorizontalBar(context),
              ).separatedBy(SizedBox(height: rowHeight)),
            ),
          ),
          if (notifier.state is LoadingDiary)
            const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          if (notifier.state is Loaded) _Content(rowHeight),
        ],
      ),
    );
  }

  Container _buildHorizontalBar(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceVariant,
      height: rowHeight,
      width: double.infinity,
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
  double _itemSize = 0;

  double _calculateItemSize() {
    final screenWidth = MediaQuery.of(context).size.width - 32;
    return screenWidth / 12;
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<DiaryDashboardNotifier>();
    _itemSize = _calculateItemSize();
    notifier.itemSize = _itemSize;
    final state = notifier.state as Loaded;
    final entries = state.entries;
    final selectedEntry = notifier.selectedEntry;
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          right: notifier.indicatorPosition,
          child: Container(
            height: widget.rowHeight * 11,
            width: _itemSize,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
        ScrollSnapList(
          margin: const EdgeInsets.only(right: 16),
          listViewPadding: const EdgeInsets.only(left: 16),
          scrollPhysics: const ClampingScrollPhysics(),
          selectedItemAnchor: SelectedItemAnchor.START,
          onItemFocus: (index) {
            final entryIndex = notifier.onItemFocus(index);
            notifier.selectEntry(entries[entryIndex]);
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
        if (entries[index].hasDiaryEntry) {
          setState(() {
            notifier.selectEntry(entries[index]);
            notifier.onItemTap(index);
          });
        }
      },
      child: SizedBox(
        height: widget.rowHeight,
        width: _itemSize,
        child: Center(child: child),
      ),
    );
  }

  double _calculateMarkerPosition(EpisodeSeverity episode) {
    return EpisodesChartHelper.calculateHeight(episode, widget.rowHeight);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
