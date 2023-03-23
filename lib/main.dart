import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'src/app.dart';

void main() async {
  Intl.defaultLocale = 'pt_BR';
  await initializeDateFormatting();
  runApp(const App());
}
