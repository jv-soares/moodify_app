import 'package:flutter/material.dart';

import 'pages/daily_entry_form_page.dart';
import 'theme/color_schemes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moodify',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      home: const DailyEntryFormPage(),
    );
  }
}
