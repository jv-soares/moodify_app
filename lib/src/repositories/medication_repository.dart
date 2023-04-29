import 'package:moodify_app/src/models/medication.dart';

abstract class MedicationRepository {
  Future<List<Medication>> readAll();
  Future<String> create(Medication medication);
  Future<void> delete(String id);
}

class TempMedicationRepository implements MedicationRepository {
  final _medications = <Medication>[];

  @override
  Future<String> create(Medication medication) async {
    await _delay;
    _medications.add(medication);
    return medication.id;
  }

  @override
  Future<void> delete(String id) async {
    await _delay;
    _medications.removeWhere((element) => element.id == id);
  }

  @override
  Future<List<Medication>> readAll() async {
    await _delay;
    return _medications;
  }

  Future<void> get _delay => Future.delayed(const Duration(seconds: 1));
}
