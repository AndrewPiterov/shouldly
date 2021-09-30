import 'package:shouldly/src/exception.dart';

class Cap<T> {
  Cap(
    this.target, {
    this.isReversed = false,
    String? targetLabel,
  }) : _targetLabel = targetLabel;

  final T target;
  final bool isReversed;
  final String? _targetLabel;

  String get targetLabel {
    final runtimeType = target.runtimeType;
    return _targetLabel == null || _targetLabel == ''
        ? 'Target ${runtimeType}'
        : _targetLabel!;
  }

  Cap<T> get and => Cap<T>(target, isReversed: isReversed);

  Cap<T> get not => Cap<T>(target, isReversed: true);

  Cap<T> as(String targetLabel) => Cap<T>(
        target,
        isReversed: isReversed,
        targetLabel: targetLabel,
      );

  Cap<T> beEqual(Object value) {
    if (isReversed) {
      if (value == this.target) {
        throw Exception(
            '\n$targetLabel should not be\n  `$value`\nbut was\n  `$target`');
      }
    } else {
      if (value != this.target) {
        throw Exception(
            '\n$targetLabel should be\n  `$value`\nbut was\n  `$target`');
      }
    }

    return Cap(this.target);
  }

  Cap<T> beTypeOf<K>() {
    if (isReversed) {
      if (target is K) {
        throw Exception(
            '\nType of $targetLabel should not be\n    `$K`\but it was');
      }
    } else {
      if (target is! K) {
        throw Exception(
            '\nType of $targetLabel should be\n    `$K`\nbut it is\n    `$T`');
      }
    }

    return Cap(target);
  }
}

extension ObjectExtensions on Object? {
  Cap<Object?> get should => Cap<Object?>(this);
}

extension ObjectCapExtensions on Cap<Object?> {
  Cap<Object?> get beNull {
    if (isReversed) {
      if (target == null) {
        throw ShouldlyTestFailure('Target should not be null');
      }
    } else {
      if (target != null) {
        throw ShouldlyTestFailure('Target should be null');
      }
    }

    return Cap(target);
  }
}
