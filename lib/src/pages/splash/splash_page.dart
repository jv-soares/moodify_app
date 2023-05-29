import 'package:flutter/material.dart';
import 'package:moodify_app/src/app.dart';
import 'package:moodify_app/src/pages/onboarding/onboarding_page.dart';
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
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    Navigator.of(context).push(_OnboardingPageRoute());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _OnboardingPageRoute extends PageRoute {
  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 450);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return const OnboardingPage();
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween(begin: const Offset(0, -1), end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeOutCubic))
          .animate(animation),
      child: child,
    );
  }
}
