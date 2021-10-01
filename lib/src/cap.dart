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
        throw ShouldlyTestFailure(
            '\n$targetLabel should not be\n  `$value`\nbut was\n  `$target`');
      }
    } else {
      if (value != this.target) {
        throw ShouldlyTestFailure(
            '\n$targetLabel should be\n  `$value`\nbut was\n  `$target`');
      }
    }

    return copy(target, targetLabel: targetLabel);
  }

  ///
  /// Check exact type
  /// And return instance of U
  U? beOfType<U>() {
    final runtimeType = target.runtimeType;
    final isNamesEqual = target.runtimeType.toString() == U.toString();
    if (isReversed) {
      if (target.runtimeType == U && isNamesEqual) {
        throw ShouldlyTestFailure(
            '\n$targetLabel\n    $runtimeType\nshould not be an instantiation of Type\n    `$U`\nbut does');
      }
    } else {
      if (target.runtimeType != U && !isNamesEqual) {
        throw ShouldlyTestFailure(
            '\n$targetLabel\n    $runtimeType\nshould be an instantiation of Type\n    `$U`\nbut does not');
      }
    }

    try {
      final x = target as U;
      return x;
    } catch (e) {
      // TODO: catch exact type cast error - example myIntNumber.should.not.beOfType<double>();
      return null;
    }
  }

  U? beAssignableTo<U>() {
    final eval = EvalCondition<T>(
      condition: (x) => x.runtimeType != U && x is U,
      target: target,
      title: 'should be subclass of $U',
    );

    if (isReversed) {
      if (eval.eval()) {
        throw ShouldlyTestFailure(
            '\n$targetLabel\n    $target\nshould not be a subbclass of\n    `$U`\nbut does');
      }
    } else {
      if (!eval.eval()) {
        throw ShouldlyTestFailure(
            '\n$targetLabel\n    $target\nshould be a subbclass of\n    `$U`\nbut does not');
      }
    }

    try {
      final x = target as U;
      return x;
    } catch (e) {
      // TODO: catch exact type cast error - example with List<String/Int/etc>
      return null;
    }
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

class EvalCondition<T> {
  bool Function(T? target) condition;
  final T? target;
  final String title;

  EvalCondition({
    required this.condition,
    required this.target,
    required this.title,
  });

  bool eval() {
    final res = condition(target);
    return res;
  }
}
