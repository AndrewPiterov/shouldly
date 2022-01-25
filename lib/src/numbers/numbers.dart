import 'package:shouldly/shouldly.dart';

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

  /// Asserts an numeric value is close to another value within a specified value.
  ///
  /// [delta] The maximum amount of which the two values may differ.
  NumericAssertions beCloseTo(num nearbyValue, {required num delta}) {
    var diff = nearbyValue - subject!;
    if (diff < 0) diff = -diff;
    final isClose = diff <= delta;

    if (isReversed) {
      Execute.assertion.forCondition(isClose).failWith(
            '$subjectLabel\n    $subject\nshould not be close to\n    $nearbyValue\nwith tolerance $delta\n    but does.',
          );
    } else {
      Execute.assertion.forCondition(!isClose).failWith(
            '$subjectLabel\n    $subject\nshould be close to\n    $nearbyValue\nwith tolerance $delta\n    but does not.',
          );
    }

    return NumericAssertions(subject);
  }

  /// Asserts an numeric value is close to another value within a specified value.
  ///
  /// [tolerance] The maximum percentage of which the two values may differ.
  NumericAssertions beTolerantOf(
    num nearbyValue, {
    required double tolerance,
  }) {
    if (tolerance >= 1 || tolerance <= 0) {
      throw ShouldlyTestFailureError(
        'Tolerance has to be greater than 0 and less than 1',
      );
    }

    final delta = subject! * tolerance;

    var diff = nearbyValue - subject!;
    if (diff < 0) diff = -diff;
    final isClose = diff <= delta;

    if (isReversed) {
      Execute.assertion.forCondition(isClose).failWith(
            '$subjectLabel\n    $subject\nshould not be tolerant of\n    $nearbyValue\nwith tolerance $tolerance%\n    but does.',
          );
    } else {
      Execute.assertion.forCondition(!isClose).failWith(
            '$subjectLabel\n    $subject\nshould be tolerant of\n    $nearbyValue\nwith tolerance $tolerance%\n    but does not.',
          );
    }

    return NumericAssertions(subject);
  }

  /// Asserts that the numeric value is less than zero.
  NumericAssertions beNegative() {
    if (isReversed) {
      Execute.assertion
          .forCondition(subject! < 0)
          .failWith('$subjectLabel\n    $subject\nshould not be negative.');
    } else {
      Execute.assertion
          .forCondition(subject! >= 0)
          .failWith('$subjectLabel\n    $subject\nshould be negative.');
    }

    return NumericAssertions(subject);
  }

  /// Asserts that the numeric value is greater or equal than zero.
  NumericAssertions bePositive() {
    if (isReversed) {
      Execute.assertion.forCondition(subject! >= 0).failWith(
            '$subjectLabel\n    $subject\nshould not be positive\n    but does.',
          );
    } else {
      Execute.assertion.forCondition(subject! < 0).failWith(
            '$subjectLabel\n    $subject\nshould be positive\n    but does not.',
          );
    }

    return NumericAssertions(subject);
  }

  /// Asserts that the numeric value is 0.
  NumericAssertions beZero() {
    if (isReversed) {
      Execute.assertion
          .forCondition(subject! == 0)
          .failWith('$subjectLabel\n    $subject\nshould not be zero.');
    } else {
      Execute.assertion
          .forCondition(subject! != 0)
          .failWith('$subjectLabel\n    $subject\nshould be zero.');
    }

    return NumericAssertions(subject);
  }

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
        throw ShouldlyTestFailureError(
          '\n$subjectLabel number\n    $subject\nshould not greater than\n    $expected',
        );
      }
    } else {
      if (subject! <= expected) {
        throw ShouldlyTestFailureError(
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
        throw ShouldlyTestFailureError(
          '\n$subjectLabel number\n    $subject\nshould not less than\n    $expected',
        );
      }
    } else {
      if (subject! >= expected) {
        throw ShouldlyTestFailureError(
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
      throw ShouldlyTestFailureError('$subject less than $expected');
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

    Execute.assertion
        .forCondition(subject! > expected)
        .failWith('$subject\n    \n$subject\nnot less than\n    $expected');

    return NumericAssertions(subject);
  }

  /// Asserts that a value is within a range.
  ///
  /// [min] The minimum valid value of the range.</param>
  /// [max] The maximum valid value of the range.</param>
  NumericAssertions beWithin(num min, num max) {
    if (isReversed) {
      if (subject! < max && subject! > min) {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel number\n    $subject\nshould not be within\n    [$min, $max]',
        );
      }
    } else {
      if (subject! > max || subject! < min) {
        throw ShouldlyTestFailureError(
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
