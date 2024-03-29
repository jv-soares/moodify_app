import 'package:collection/collection.dart';
import 'package:moodify_app/src/models/taken_medication.dart';
import 'package:moodify_app/src/services/diary_entry_service.dart';

import '../../../app_container.dart';
import '../../../models/fetch_notifier.dart';

class MedicationNotifier extends FetchNotifier<List<TakenMedication>> {
  final _service = AppContainer.get<DiaryEntryService>();

  MedicationNotifier() {
    _initialize();
  }

  Future<void> _initialize() async {
    final entries = await _service.readAll();
    if (entries.isEmpty) {
      data = [];
    } else {
      final medications = entries
          .firstWhereOrNull((element) => element.medications.isNotEmpty)
          ?.medications;
      data = medications ?? [];
    }
  }

  void add(TakenMedication medication) {
    final identifiedMedication = medication.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    data = [...?data, identifiedMedication];
  }

  void remove(TakenMedication medication) {
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
    if (medication.tabletsTaken == 1) return remove(medication);
    _updateMedicationAt(index, medication.decrementedTablets());
  }

  void _updateMedicationAt(int index, TakenMedication medication) {
    data = [
      ...data!
        ..removeAt(index)
        ..insert(index, medication)
    ];
  }

  bool get isEmpty => data!.isEmpty;
}
