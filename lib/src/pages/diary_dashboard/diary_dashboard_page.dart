import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodify_app/src/app.dart';
import 'package:moodify_app/src/pages/diary_dashboard/components/episodes_chart.dart';
import 'package:moodify_app/src/pages/diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import 'package:moodify_app/src/utils/string_x.dart';
import 'package:provider/provider.dart';

import 'components/diary_entry_draggable_bottom_sheet.dart';

class DiaryDashboardPage extends StatelessWidget {
  const DiaryDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<DiaryDashboardNotifier>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: notifier.canAddEntry
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.diaryForm);
              },
            )
          : null,
      appBar: AppBar(
        centerTitle: true,
        title: AnimatedBuilder(
          animation: notifier,
          builder: (context, _) {
            DateTime date = DateTime.now();
            if (notifier.state is Loaded) {
              date = (notifier.state as Loaded)
                  .selectedEntry
                  .diaryEntry!
                  .createdAt;
            }
            return Text(
              DateFormat.yMMMM().format(date).capitalize(),
            );
          },
        ),
        leading: Theme(
          data: Theme.of(context).copyWith(useMaterial3: false),
          child: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                final selectedRange = await showDateRangePicker(
                  context: context,
                  firstDate: notifier.oldestEntry?.date ?? DateTime.now(),
                  lastDate: notifier.newestEntry?.date ?? DateTime.now(),
                  saveText: 'Salvar',
                  locale: Localizations.localeOf(context),
                );
                if (selectedRange != null) {
                  notifier.selectDateRange(
                    selectedRange.start,
                    selectedRange.end,
                  );
                }
              },
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.notifications);
            },
          ),
        ],
      ),
      body: Stack(
        children: const [
          EpisodesChart(),
          DiaryEntryDraggableBottomSheet(),
        ],
      ),
    );
  }
}
