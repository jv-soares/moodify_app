import 'package:collection/collection.dart';
import 'package:moodify_app/src/app_container.dart';
import 'package:moodify_app/src/models/diary_entry.dart';
import 'package:moodify_app/src/repositories/diary_entry_repository.dart';
import 'package:rxdart/subjects.dart';

class DiaryEntryService {
  final _repository = AppContainer.get<DiaryEntryRepository>();

  final _controller = BehaviorSubject<List<DiaryEntry>>();

  Future<String> create(DiaryEntry entry) {
    return entry.id != null ? _update(entry) : _create(entry);
  }

  Future<String> _update(DiaryEntry entry) {
    final index = _controller.value.indexWhere((e) => e.id == entry.id);
    final newList = [..._controller.value];
    newList[index] = entry;
    _controller.add(newList);
    return _repository.update(entry);
  }

  Future<String> _create(DiaryEntry entry) {
    if (_controller.hasValue) {
      _controller.add([..._controller.value, entry]);
    } else {
      _controller.add([entry]);
    }
    return _repository.create(entry);
  }

  Stream<List<DiaryEntry>> watchAll() async* {
    if (!_controller.hasValue) {
      final entries = await readAll();
      _controller.add(entries);
    }
    yield* _controller.map((event) => event.sortedByCreationDate());
  }

  Future<List<DiaryEntry>> readAll() {
    return _repository.readAll();
  }
}

extension on List<DiaryEntry> {
  List<DiaryEntry> sortedByCreationDate({bool ascending = false}) {
    return sortedByCompare(
      (e) => e.createdAt,
      (a, b) => ascending ? a.compareTo(b) : b.compareTo(a),
    );
  }
}
