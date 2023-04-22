import 'package:flutter/widgets.dart';

import '../core/failures.dart';

class FetchNotifier<T> extends ChangeNotifier {
  T? get data => _data;
  T? _data;
  set data(T? value) {
    _data = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  bool _isLoading = true;

  Failure? get failure => _failure;
  Failure? _failure;

  bool get hasData => _data != null;
  bool get hasFailure => _failure != null;

  Future<void> fetch(Future<T> Function() future) async {
    try {
      startLoading();
      final data = await future();
      _data = data;
    } on Failure catch (e) {
      _failure = e;
    } finally {
      stopLoading();
    }
  }

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
