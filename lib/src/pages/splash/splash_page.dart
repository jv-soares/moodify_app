import 'package:flutter/material.dart';
import 'package:moodify_app/src/app.dart';
import 'package:provider/provider.dart';

import '../diary_dashboard/notifiers/diary_dashboard_notifier.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late DiaryDashboardNotifier _dashboardNotifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dashboardNotifier = context.read<DiaryDashboardNotifier>();
    _dashboardNotifier.initialize();
    _dashboardNotifier.addListener(_onDashboardStateChanged);
  }

  void _onDashboardStateChanged() {
    final state = _dashboardNotifier.state;
    if (state is Loaded) {
      if (state.entries.isEmpty) _pushFormPage();
      _pushDashboardPage();
    } else {
      _pushFormPage();
    }
  }

  void _pushFormPage() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.diaryForm);
  }

  void _pushDashboardPage() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  @override
  void dispose() {
    _dashboardNotifier.removeListener(_onDashboardStateChanged);
    super.dispose();
  }
}
