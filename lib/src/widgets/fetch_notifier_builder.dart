import 'package:flutter/material.dart';

import '../core/failures.dart';
import '../models/fetch_notifier.dart';

class FetchNotifierBuilder<T> extends StatelessWidget {
  final FetchNotifier<T> notifier;
  final Widget Function()? onLoading;
  final Widget Function(T data)? onSuccess;
  final Widget Function(Failure failure)? onFailure;

  const FetchNotifierBuilder({
    super.key,
    required this.notifier,
    this.onLoading,
    this.onSuccess,
    this.onFailure,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: notifier,
      builder: (context, _) {
        Widget? result;
        if (notifier.isLoading) {
          result = onLoading?.call();
        }
        if (notifier.hasData) {
          result = onSuccess?.call(notifier.data as T);
        }
        if (notifier.hasFailure) {
          result = onFailure?.call(notifier.failure!);
        }
        return result ?? const SizedBox.shrink();
      },
    );
  }
}
