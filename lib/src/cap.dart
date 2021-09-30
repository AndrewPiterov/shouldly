import 'package:shouldly/src/exception.dart';

abstract class Cap<T, K> {
  Cap(
    this.target, {
    this.isReversed = false,
    String? targetLabel,
  }) : _targetLabel = targetLabel;

  final T? target;
  final bool isReversed;
  final String? _targetLabel;

  String get targetLabel {
    final runtimeType = target.runtimeType;
    return _targetLabel == null || _targetLabel == ''
        ? 'Target ${runtimeType}'
        : _targetLabel!;
  }

  K copy(T? target, {bool isReversed = false, String? targetLabel});

  K get and => copy(target, isReversed: isReversed, targetLabel: targetLabel);

  K get not => copy(target, isReversed: true, targetLabel: targetLabel);

  K as(String targetLabel) =>
      copy(target, isReversed: isReversed, targetLabel: targetLabel);

  K beEqual(Object value) {
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

    return copy(target, targetLabel: targetLabel);
  }

  K beTypeOf<Q>() {
    if (isReversed) {
      if (target is Q) {
        throw Exception(
            '\nType of $targetLabel should not be\n    `$Q`\but it was');
      }
    } else {
      if (target is! Q) {
        throw Exception(
            '\nType of $targetLabel should be\n    `$Q`\nbut it is\n    `$T`');
      }
    }

    return copy(target, targetLabel: targetLabel);
  }

  K get beNull {
    if (isReversed) {
      if (target == null) {
        throw ShouldlyTestFailure('\n$targetLabel should not be null');
      }
    } else {
      if (target != null) {
        throw ShouldlyTestFailure('\n$targetLabel should be null');
      }
    }

    return copy(target, targetLabel: targetLabel);
  }
}
