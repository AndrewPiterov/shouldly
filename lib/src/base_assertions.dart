import 'package:shouldly/src/eva_condition.dart';
import 'package:shouldly/src/exception.dart';

/// Base Matcher
abstract class BaseAssertions<T, K> {
  /// Matcher constructor
  BaseAssertions(
    this.target, {
    this.isReversed = false,
    String? targetLabel,
  }) : _targetLabel = targetLabel;

  /// the object which value is being asserted.
  final T? target;

  /// Checking reverse
  final bool isReversed;

  final String? _targetLabel;

  /// Friendly label for the target object
  String get targetLabel {
    final runtimeType = target.runtimeType;
    return _targetLabel == null || _targetLabel == ''
        ? 'Target $runtimeType'
        : _targetLabel!;
  }

  /// Copy the matcher
  K copy(T? target, {bool isReversed = false, String? targetLabel});

  /// For conjuction
  K get and => copy(target, isReversed: isReversed, targetLabel: targetLabel);

  /// Invert assertion
  K get not => copy(target, isReversed: true, targetLabel: targetLabel);

  /// Set friendly title for the target
  K as(String targetLabel) =>
      copy(target, isReversed: isReversed, targetLabel: targetLabel);

  /// Check equality to value
  K be(Object value) {
    if (isReversed) {
      if (value == target) {
        throw ShouldlyTestFailure(
          '\n$targetLabel should not be\n  `$value`\nbut was\n  `$target`',
        );
      }
    } else {
      if (value != target) {
        throw ShouldlyTestFailure(
          '\n$targetLabel should be\n  `$value`\nbut was\n  `$target`',
        );
      }
    }

    return copy(target, targetLabel: targetLabel);
  }

  /// Asserts that the object is not of the specified type `U`
  U? beOfType<U>() {
    final runtimeType = target.runtimeType;
    final isNamesEqual = target.runtimeType.toString() == U.toString();
    if (isReversed) {
      if (target.runtimeType == U && isNamesEqual) {
        throw ShouldlyTestFailure(
          '\n$targetLabel\n    $runtimeType\nshould not be an instantiation of Type\n    `$U`\nbut does',
        );
      }
    } else {
      if (target.runtimeType != U && !isNamesEqual) {
        throw ShouldlyTestFailure(
          '\n$targetLabel\n    $runtimeType\nshould be an instantiation of Type\n    `$U`\nbut does not',
        );
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

  /// Asserts that the object is assignable to a variable of type `U`
  U? beAssignableTo<U>() {
    final eval = EvalCondition<T>(
      condition: (x) => x.runtimeType != U && x is U,
      target: target,
      errorMessage:
          '\n$targetLabel\n    $target\nshould not be a subbclass of\n    `$U`\nbut does',
      errorMessageForReverse:
          '\n$targetLabel\n    $target\nshould be a subbclass of\n    `$U`\nbut does not',
    );

    eval.eval(isReversed: isReversed);

    try {
      final x = target as U;
      return x;
    } catch (e) {
      // TODO: catch exact type cast error - example with List<String/Int/etc>
      return null;
    }
  }

  /// Check on null
  K get beNull {
    final eval = EvalCondition<T>(
      condition: (x) => x == null,
      target: target,
      errorMessage: '\n$targetLabel should be null',
      errorMessageForReverse: '\n$targetLabel should not be null',
    );

    eval.eval(isReversed: isReversed);

    return copy(target, targetLabel: targetLabel);
  }
}
