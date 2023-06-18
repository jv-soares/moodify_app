import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import '../pages/diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import '../utils/string_x.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<DiaryDashboardNotifier>();
    return AppBar(
      centerTitle: true,
      title: AnimatedBuilder(
        animation: notifier,
        builder: (context, _) {
          DateTime date = DateTime.now();
          if (notifier.state is Loaded) {
            if (notifier.selectedEntry != null) {
              date = notifier.selectedEntry!.diaryEntry!.createdAt;
            }
          }
          return Text(
            DateFormat.yMMMM().format(date).capitalize(),
          );
        },
      ),
      leading: IconButton(
        icon: const Icon(Icons.calendar_today),
        onPressed: () async {
          final selectedRange = await showDateRangePicker(
            context: context,
            firstDate: notifier.oldestEntry?.date ?? DateTime.now(),
            lastDate: notifier.newestEntry?.date ?? DateTime.now(),
            saveText: 'Salvar',
            locale: Localizations.localeOf(context),
            selectableDayPredicate: (day) => !notifier.canAddEntryAt(day),
          );
          if (selectedRange != null) {
            notifier.selectDateRange(
              selectedRange.start,
              selectedRange.end,
            );
          }
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.notifications);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
