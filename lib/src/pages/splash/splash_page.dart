import 'package:flutter/material.dart';
import 'package:moodify_app/src/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _shouldOnboard();
  }

  Future<void> _shouldOnboard() async {
    final sharedPref = await SharedPreferences.getInstance();
    final didOnboard = sharedPref.getBool('didOnboard') ?? false;
    didOnboard ? _pushHome() : _pushOnboarding();
  }

  void _pushHome() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  void _pushOnboarding() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
