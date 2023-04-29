import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/diary_entry_form/diary_entry_form_page.dart';
import 'package:moodify_app/src/pages/diary_entry_form/episode_severity_form_page.dart';
import 'package:moodify_app/src/pages/diary_entry_form/view_models/diary_entry_view_model.dart';
import 'package:provider/provider.dart';

class DiaryEntryFormFlow extends StatefulWidget {
  const DiaryEntryFormFlow({super.key});

  @override
  State<DiaryEntryFormFlow> createState() => _DiaryEntryFormFlowState();
}

class _DiaryEntryFormFlowState extends State<DiaryEntryFormFlow> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => DiaryEntryViewModel(),
      child: Navigator(
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
    );
  }
}
