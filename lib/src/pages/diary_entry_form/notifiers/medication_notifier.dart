import 'package:moodify_app/src/models/medication.dart';

import '../../../app_container.dart';
import '../../../models/fetch_notifier.dart';
import '../../../repositories/medication_repository.dart';

class MedicationsNotifier extends FetchNotifier<List<Medication>> {
  final _repository = AppContainer.get<MedicationRepository>();

  MedicationsNotifier() {
    _initialize();
  }

  Future<void> _initialize() async {
    final medications = await _repository.readAll();
    data = medications;
  }

  void add(Medication medication) {
    data = [...?data, medication];
  }

  void remove(Medication medication) {
    data = data?..remove(medication);
  }

  void incrementTabletsTaken(String medicationId) {
    final index = data!.indexWhere((e) => e.id == medicationId);
    final medication = data![index];
    if (medication.tabletsTaken >= 10) return;
    _updateMedicationAt(index, medication.incrementedTablets());
  }

  void decrementTabletsTaken(String medicationId) {
    final index = data!.indexWhere((e) => e.id == medicationId);
    final medication = data![index];
    if (medication.tabletsTaken <= 0) return;
    _updateMedicationAt(index, medication.decrementedTablets());
  }

  void _updateMedicationAt(int index, Medication medication) {
    data = [
      ...data!
        ..removeAt(index)
        ..insert(index, medication)
    ];
  }

  bool get isEmpty => data!.isEmpty;
}
