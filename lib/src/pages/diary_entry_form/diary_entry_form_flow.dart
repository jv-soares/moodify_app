import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodify_app/src/pages/diary_entry_form/diary_entry_form_page.dart';
import 'package:moodify_app/src/pages/diary_entry_form/episode_severity_form_page.dart';
import 'package:moodify_app/src/pages/diary_entry_form/view_models/diary_entry_view_model.dart';
import 'package:provider/provider.dart';

import '../../utils/date_time_utils.dart';
import '../diary_dashboard/notifiers/diary_dashboard_notifier.dart';

class DiaryEntryFormFlow extends StatefulWidget {
  const DiaryEntryFormFlow({super.key});

  @override
  State<DiaryEntryFormFlow> createState() => _DiaryEntryFormFlowState();
}

class _DiaryEntryFormFlowState extends State<DiaryEntryFormFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  DateTime _selectedDate = DateTime.now();

  DateTime get _today => DateTime.now();

  String _getFormattedDate() {
    final yesterday = _today.subtract(const Duration(days: 1));
    if (DateTimeUtils.compareDayOfYear(_selectedDate, _today)) {
      return 'Hoje';
    } else if (DateTimeUtils.compareDayOfYear(_selectedDate, yesterday)) {
      return 'Ontem';
    }
    return DateFormat.MMMMd().format(_selectedDate);
  }

  void _selectDate() {
    final notifier = context.read<DiaryDashboardNotifier>();
    showDatePicker(
      context: context,
      initialDate: notifier.addableDays.first,
      firstDate: _today.subtract(const Duration(days: 7)),
      lastDate: _today,
      selectableDayPredicate: notifier.canAddEntryAt,
    ).then((date) {
      if (date != null) {
        setState(() => _selectedDate = date);
        context.read<DiaryEntryViewModel>().createdAt = _selectedDate;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<DiaryDashboardNotifier>();
    return Provider(
      create: (_) => DiaryEntryViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_getFormattedDate()),
          centerTitle: true,
          leading: notifier.isEmpty
              ? null
              : IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const Icon(Icons.close),
                ),
          actions: [
            IconButton(
              onPressed: _selectDate,
              icon: const Icon(Icons.edit_calendar),
            ),
          ],
        ),
        body: Navigator(
          key: _navigatorKey,
          initialRoute: 'diary-form/episode-severity',
          onGenerateRoute: (settings) {
            late WidgetBuilder builder;
            switch (settings.name) {
              case 'diary-form/episode-severity':
                builder = (_) => const EpisodeSeverityFormPage();
                break;
              case 'diary-form/optional':
                builder = (_) => DiaryEntryFormPage(
                      onFormSaved: Navigator.of(context).pop,
                    );
                break;
              default:
                throw Exception('invalid route ${settings.name}');
            }
            return MaterialPageRoute(builder: builder);
          },
        ),
      ),
    );
  }
}
