import 'package:flutter/material.dart';

import 'home_page.dart';
import 'theme/color_schemes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moodify',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
