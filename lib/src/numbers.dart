import 'package:shouldly/src/base_assertions.dart';
import 'package:shouldly/src/eva_condition.dart';
import 'package:shouldly/src/exception.dart';

/// Contains Numbers's extension methods for custom assertions in unit tests.
extension NumExtensions on num {
  /// Returns an `NumAssertions` object that can be used to assert the
  /// current `num` />.
  NumericAssertions get should => NumericAssertions(this);
}

/// Contains a number of methods to assert that a `num` is in the expected state.
class NumericAssertions extends BaseAssertions<num, NumericAssertions> {
  /// Initializes a new instance of the `NumericAssertions` class.
  NumericAssertions(
    num? target, {
    bool isReversed = false,
    String? targetLabel,
  }) : super(target, isReversed: isReversed, targetLabel: targetLabel);

  /// Asserts that the numeric value is odd.
  NumericAssertions beOdd() {
    final eval = EvalCondition(
      condition: (x) => target! % 2 != 0,
      target: target,
      errorMessage: '\n$targetLabel\n    $target\nshould be odd number.',
      errorMessageForReverse:
          '\n$targetLabel\n    $target\nshould not be odd number.',
    );

    eval.eval(isReversed: isReversed);

    return NumericAssertions(target);
  }

  /// Asserts that the numeric value is even.
  NumericAssertions beEven() {
    final eval = EvalCondition(
      condition: (x) => target! % 2 == 0,
      target: target,
      errorMessage: '\n$targetLabel\n    $target\nshould be even number.',
      errorMessageForReverse:
          '\n$targetLabel\n    $target\nshould not be even number.',
    );

    eval.eval(isReversed: isReversed);

    return NumericAssertions(target);
  }

  /// Asserts that the numeric value is odd.
  NumericAssertions beGreaterThan(num value) {
    if (isReversed) {
      if (target! > value) {
        throw ShouldlyTestFailure(
          '\n$targetLabel number\n    $target\nshould not greater than\n    $value',
        );
      }
    } else {
      if (target! <= value) {
        throw ShouldlyTestFailure(
          '\n$targetLabel number\n    $target\nshould be greater than\n    $value',
        );
      }
    }

    return NumericAssertions(target);
  }

  /// Asserts that the numeric value is greater than the specified [expected] value.
  ///
  /// [expected] The value to compare the current numeric value with.
  NumericAssertions beAbove(num expected) {
    return beGreaterThan(expected);
  }

  /// Asserts that the numeric value is less than the specified [expected] value.
  ///
  /// [expected] The value to compare the current numeric value with.
  NumericAssertions beLessThan(num expected) {
    if (isReversed) {
      if (target! < expected) {
        throw ShouldlyTestFailure(
          '\n$targetLabel number\n    $target\nshould not less than\n    $expected',
        );
      }
    } else {
      if (target! >= expected) {
        throw ShouldlyTestFailure(
          '\n$targetLabel number\n    $target\nshould be less than\n    $expected',
        );
      }
    }

    return NumericAssertions(target);
  }

  /// Asserts that the numeric value is less than the specified [expected] value.
  ///
  /// [expected] The value to compare the current numeric value with.
  NumericAssertions beBelow(num expected) {
    return beLessThan(expected);
  }

  /// Asserts that the numeric value is greater or equal than the specified [expected] value.
  ///
  /// [expected] The value to compare the current numeric value with.
  NumericAssertions beGreaterOrEqualThan(num expected) {
    if (isReversed) {
      return NumericAssertions(target).beLessOrEqualThan(expected);
    }

    if (target! < expected) {
      throw ShouldlyTestFailure('$target less than $expected');
    }

    return NumericAssertions(target);
  }

  /// Asserts that the numeric value is less or equal than the specified [expected] value.
  ///
  /// [expected] The value to compare the current numeric value with.
  NumericAssertions beLessOrEqualThan(num expected) {
    if (isReversed) {
      return NumericAssertions(target).beGreaterOrEqualThan(expected);
    }

    final m = expected + 1;
    if (target! > m) {
      throw ShouldlyTestFailure('$target is not less than $m');
    }

    return NumericAssertions(target);
  }

  /// Asserts that a value is within a range.
  ///
  /// [min] The minimum valid value of the range.</param>
  /// [max] The maximum valid value of the range.</param>
  NumericAssertions beWithin(num min, num max) {
    if (isReversed) {
      if (target! < max && target! > min) {
        throw ShouldlyTestFailure(
          '\n$targetLabel number\n    $target\nshould not be within\n    [$min, $max]',
        );
      }
    } else {
      if (target! > max || target! < min) {
        throw ShouldlyTestFailure(
          '\n$targetLabel number\n    $target\nshould be within\n    [$min, $max]',
        );
      }
    }

    return NumericAssertions(target);
  }

  @override
  NumericAssertions copy(
    num? target, {
    bool isReversed = false,
    String? targetLabel,
  }) {
    return NumericAssertions(
      target,
      isReversed: isReversed,
      targetLabel: targetLabel,
    );
  }
}
