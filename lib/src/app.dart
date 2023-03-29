import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/diary_entry_form/diary_entry_form_page.dart';
import 'theme/color_schemes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moodify',
      theme: _buildTheme(),
      home: const DiaryEntryFormPage(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
    );
  }
}

ThemeData _buildTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
  );
}
