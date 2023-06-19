import 'package:flutter/material.dart';

enum Symptom { menstruation, dysphoricMania, anxiety, panicAttack }

extension SymptomX on Symptom {
  IconData get icon {
    return switch (this) {
      Symptom.anxiety => Icons.monitor_heart_outlined,
      Symptom.dysphoricMania => Icons.battery_charging_full,
      Symptom.menstruation => Icons.bloodtype,
      Symptom.panicAttack => Icons.warning_amber,
    };
  }

  String get localizedName {
    return switch (this) {
      Symptom.anxiety => 'Ansiedade',
      Symptom.dysphoricMania => 'Mania disfórica',
      Symptom.menstruation => 'Menstruação',
      Symptom.panicAttack => 'Crise de pânico',
    };
  }
}
