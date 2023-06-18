import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodify_app/src/pages/diary_entry_form/diary_entry_form_page.dart';
import 'package:moodify_app/src/pages/diary_entry_form/episode_severity_form_page.dart';
import 'package:moodify_app/src/pages/diary_entry_form/view_models/diary_entry_view_model.dart';
import 'package:provider/provider.dart';

import '../../models/diary_entry.dart';
import '../../utils/date_time_utils.dart';
import '../diary_dashboard/notifiers/diary_dashboard_notifier.dart';

class DiaryEntryFormFlow extends StatefulWidget {
  const DiaryEntryFormFlow({super.key});

  @override
  State<DiaryEntryFormFlow> createState() => _DiaryEntryFormFlowState();
}

class _DiaryEntryFormFlowState extends State<DiaryEntryFormFlow> {
  final _viewModel = DiaryEntryViewModel();
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final editable = ModalRoute.of(context)!.settings.arguments as DiaryEntry?;
    if (editable != null) {
      _viewModel.initFromModel(editable);
    } else {
      final notifier = context.read<DiaryDashboardNotifier>();
      _viewModel.update(createdAt: notifier.addableDays.first);
    }
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Registro adicionado'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: _DateAppBar(),
        body: Navigator(
          key: _navigatorKey,
          initialRoute: 'diary-form/episode-severity',
          onGenerateRoute: (settings) {
            late WidgetBuilder builder;
            switch (settings.name) {
              case 'diary-form/episode-severity':
                builder = (_) => const EpisodeSeverityFormPage();
              case 'diary-form/optional':
                builder = (_) => DiaryEntryFormPage(
                      onFormSaved: () {
                        Navigator.of(context).pop();
                        _showSnackBar();
                      },
                    );
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

class _DateAppBar extends StatelessWidget implements PreferredSizeWidget {
  DateTime get _today => DateTime.now();

  String _getFormattedDate(DateTime selectedDate) {
    final yesterday = _today.subtract(const Duration(days: 1));
    if (DateTimeUtils.compareDayOfYear(selectedDate, _today)) {
      return 'Hoje';
    } else if (DateTimeUtils.compareDayOfYear(selectedDate, yesterday)) {
      return 'Ontem';
    }
    return DateFormat.MMMMd().format(selectedDate);
  }

  Future<DateTime?> _selectDate(
    BuildContext context,
    DateTime selectedDate, {
    bool isEditing = false,
  }) {
    final notifier = context.read<DiaryDashboardNotifier>();
    return showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: _today.subtract(const Duration(days: 7)),
      lastDate: _today,
      selectableDayPredicate: isEditing ? null : notifier.canAddEntryAt,
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<DiaryDashboardNotifier>();
    final viewModel = context.watch<DiaryEntryViewModel>();
    return AppBar(
      title: Text(_getFormattedDate(viewModel.createdAt)),
      centerTitle: true,
      leading: notifier.isEmpty
          ? null
          : IconButton(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(Icons.close),
            ),
      actions: [
        IconButton(
          onPressed: () => _selectDate(
            context,
            viewModel.createdAt,
            isEditing: viewModel.isEditing,
          ).then((date) {
            if (date != null) {
              context.read<DiaryEntryViewModel>().update(createdAt: date);
            }
          }),
          icon: const Icon(Icons.edit_calendar),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
