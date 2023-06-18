import 'dart:math';

import 'package:moodify_app/src/models/taken_medication.dart';

abstract class MedicationRepository {
  Future<List<TakenMedication>> readAll();
  Future<String> create(TakenMedication medication);
  Future<void> delete(String id);
}

class TempMedicationRepository implements MedicationRepository {
  final _medications = <TakenMedication>[];

  @override
  Future<String> create(TakenMedication medication) async {
    await _delay;
    _medications.add(medication);
    return Random().nextInt(100).toString();
  }

  @override
  Future<void> delete(String id) async {
    await _delay;
    _medications.removeWhere((element) => element.id == id);
  }

  @override
  Future<List<TakenMedication>> readAll() async {
    await _delay;
    return _medications;
  }

  Future<void> get _delay => Future.delayed(const Duration(seconds: 1));
}
