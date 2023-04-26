import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moodify_app/src/app_container.dart';
import 'package:moodify_app/src/pages/diary_dashboard/diary_dashboard_page.dart';
import 'package:moodify_app/src/pages/diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import 'package:moodify_app/src/pages/diary_entry_form/diary_entry_form_page.dart';
import 'package:moodify_app/src/pages/home_page.dart';
import 'package:moodify_app/src/pages/notifications/notifications_page.dart';
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
        initialRoute: '/',
        routes: _buildRoutes(),
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

Map<String, WidgetBuilder> _buildRoutes() {
  return {
    AppRoutes.splash: (context) => const SplashPage(),
    AppRoutes.home: (context) => const HomePage(),
    AppRoutes.diaryForm: (context) => const DiaryEntryFormPage(),
    AppRoutes.diaryDashboard: (context) => const DiaryDashboardPage(),
    AppRoutes.notifications: (context) => const NotificationsPage(),
  };
}

abstract class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const diaryForm = '/home/diary-form';
  static const diaryDashboard = '/home/diary-dashboard';
  static const notifications = '/home/notifications';
}
