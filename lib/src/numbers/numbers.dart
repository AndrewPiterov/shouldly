import 'package:shouldly/src/base_assertions.dart';
import 'package:shouldly/src/exception.dart';
import 'package:shouldly/src/execute_assertion.dart';

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
    num? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) : super(subject, isReversed: isReversed, subjectLabel: subjectLabel);

  /// Asserts that the numeric value is odd.
  NumericAssertions beOdd() {
    if (isReversed) {
      Execute.assertion
          .forCondition(subject! % 2 != 0)
          .failWith('$subjectLabel\n    $subject\nshould not be odd number.');
    } else {
      Execute.assertion
          .forCondition(subject! % 2 == 0)
          .failWith('$subjectLabel\n    $subject\nshould be odd number.');
    }

    return NumericAssertions(subject);
  }

  /// Asserts that the numeric value is even.
  NumericAssertions beEven() {
    if (isReversed) {
      Execute.assertion
          .forCondition(subject! % 2 == 0)
          .failWith('$subjectLabel\n    $subject\nshould not be even number.');
    } else {
      Execute.assertion
          .forCondition(subject! % 2 != 0)
          .failWith('$subjectLabel\n    $subject\nshould be even number.');
    }

    return NumericAssertions(subject);
  }

  /// Asserts that the numeric value is odd.
  NumericAssertions beGreaterThan(num expected) {
    if (isReversed) {
      if (subject! > expected) {
        throw ShouldlyTestFailure(
          '\n$subjectLabel number\n    $subject\nshould not greater than\n    $expected',
        );
      }
    } else {
      if (subject! <= expected) {
        throw ShouldlyTestFailure(
          '\n$subjectLabel number\n    $subject\nshould be greater than\n    $expected',
        );
      }
    }

    return NumericAssertions(subject);
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
      if (subject! < expected) {
        throw ShouldlyTestFailure(
          '\n$subjectLabel number\n    $subject\nshould not less than\n    $expected',
        );
      }
    } else {
      if (subject! >= expected) {
        throw ShouldlyTestFailure(
          '\n$subjectLabel number\n    $subject\nshould be less than\n    $expected',
        );
      }
    }

    return NumericAssertions(subject);
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
      return NumericAssertions(subject).beLessOrEqualThan(expected);
    }

    if (subject! < expected) {
      throw ShouldlyTestFailure('$subject less than $expected');
    }

    return NumericAssertions(subject);
  }

  /// Asserts that the numeric value is less or equal than the specified [expected] value.
  ///
  /// [expected] The value to compare the current numeric value with.
  NumericAssertions beLessOrEqualThan(num expected) {
    if (isReversed) {
      return NumericAssertions(subject).beGreaterOrEqualThan(expected);
    }

    final m = expected + 1;
    if (subject! > m) {
      throw ShouldlyTestFailure('$subject is not less than $m');
    }

    return NumericAssertions(subject);
  }

  /// Asserts that a value is within a range.
  ///
  /// [min] The minimum valid value of the range.</param>
  /// [max] The maximum valid value of the range.</param>
  NumericAssertions beWithin(num min, num max) {
    if (isReversed) {
      if (subject! < max && subject! > min) {
        throw ShouldlyTestFailure(
          '\n$subjectLabel number\n    $subject\nshould not be within\n    [$min, $max]',
        );
      }
    } else {
      if (subject! > max || subject! < min) {
        throw ShouldlyTestFailure(
          '\n$subjectLabel number\n    $subject\nshould be within\n    [$min, $max]',
        );
      }
    }

    return NumericAssertions(subject);
  }

  @override
  NumericAssertions copy(
    num? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) {
    return NumericAssertions(
      subject,
      isReversed: isReversed,
      subjectLabel: subjectLabel,
    );
  }
}
