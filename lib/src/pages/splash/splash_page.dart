import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../diary_dashboard/diary_dashboard_page.dart';
import '../diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import '../diary_entry_form/diary_entry_form_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final dashboardNotifier = context.read<DiaryDashboardNotifier>();
    dashboardNotifier.initialize().then(
          (_) => _onDashboardStateChanged(dashboardNotifier.state),
        );
  }

  void _onDashboardStateChanged(DiaryDashboardState state) {
    if (state is Loaded) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const DiaryDashboardPage()),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const DiaryEntryFormPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
