import 'package:flutter/material.dart';

import 'home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Moodify',
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
