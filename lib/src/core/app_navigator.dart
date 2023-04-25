import 'package:flutter/widgets.dart';

class AppNavigator {
  final GlobalKey<NavigatorState> key;

  AppNavigator(this.key);

  NavigatorState get state => key.currentState!;
}
