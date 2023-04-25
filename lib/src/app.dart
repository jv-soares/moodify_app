import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moodify_app/src/app_container.dart';
import 'package:moodify_app/src/pages/diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import 'package:moodify_app/src/pages/splash/splash_page.dart';
import 'package:provider/provider.dart';

import 'core/app_navigator.dart';
import 'theme/color_schemes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DiaryDashboardNotifier(),
      child: MaterialApp(
        title: 'Moodify',
        theme: _buildTheme(),
        navigatorKey: AppContainer.get<AppNavigator>().key,
        home: const SplashPage(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('pt', 'BR')],
      ),
    );
  }
}

ThemeData _buildTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
  );
}
