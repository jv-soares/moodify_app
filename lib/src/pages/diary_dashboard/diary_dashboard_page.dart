import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodify_app/src/pages/diary_dashboard/components/episodes_chart.dart';
import 'package:moodify_app/src/pages/diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import 'package:moodify_app/src/pages/diary_entry_form/diary_entry_form_page.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const DiaryEntryFormPage(),
          ));
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      appBar: AppBar(
        title: AnimatedBuilder(
          animation: notifier,
          builder: (context, _) => Text(
            DateFormat.yMMMM()
                .format(notifier.selectedEntry?.diaryEntry?.createdAt ??
                    DateTime.now())
                .capitalize(),
          ),
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
            icon: const Icon(Icons.settings),
            onPressed: () {},
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
