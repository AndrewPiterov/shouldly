import 'package:shouldly/src/base_assertions.dart';
import 'package:shouldly/src/execute_assertion.dart';

/// Contains DateTime's extension methods for custom assertions in unit tests.
extension DateTimeExtension on DateTime {
  /// Returns an `DateTimeAssertions` object that can be used to assert the
  /// current `DateTime` />.
  DateTimeAssertions get should => DateTimeAssertions(this);
}

/// Contains a number of methods to assert that a `DateTime` is in the expected state.
class DateTimeAssertions extends BaseAssertions<DateTime, DateTimeAssertions> {
  /// Initializes a new instance of the `DateTimeAssertions` class.
  DateTimeAssertions(
    DateTime? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) : super(subject, isReversed: isReversed, subjectLabel: subjectLabel);

  /// Asserts that the current `DateTime`  is within the specified `Duration`
  ///
  /// [nearbyValue] The expected time to compare the actual value with.
  ///
  /// [delta] The maximum duration of which the two values may differ.
  DateTimeAssertions beCloseTo(
    DateTime nearbyValue, {
    required Duration delta,
  }) {
    var diff = nearbyValue.difference(subject!).inMicroseconds;
    if (diff < 0) diff = -diff;
    final isClose = diff <= delta.inMicroseconds;

    if (isReversed) {
      Execute.assertion.forCondition(isClose).failWith(
            '$subjectLabel\n    $subject\nshould not be close to\n    $nearbyValue\nwith duration $delta\n    but does.',
          );
    } else {
      Execute.assertion.forCondition(!isClose).failWith(
            '$subjectLabel\n    $subject\nshould be close to\n    $nearbyValue\nwith duration $delta\n    but does not.',
          );
    }

    return DateTimeAssertions(subject);
  }

  /// Asserts that the current `DateTime` is after the specified value.
  ///
  /// [expected] The `DateTime` that the current value is expected to be after
  DateTimeAssertions beAfter(DateTime expected) {
    if (isReversed) {
      Execute.assertion.forCondition(subject!.isAfter(expected)).failWith(
            '$subjectLabel\n    $subject\nshould not be after\n    $expected\n    but does.',
          );
    } else {
      Execute.assertion.forCondition(!subject!.isAfter(expected)).failWith(
            '$subjectLabel\n    $subject\nshould be after\n    $expected\n    but does not.',
          );
    }

    return DateTimeAssertions(subject);
  }

  /// Asserts that the current `DateTime` is before the specified value.
  ///
  /// [expected] The `DateTime` that the current value is expected to be before
  DateTimeAssertions beBefore(DateTime expected) {
    if (isReversed) {
      Execute.assertion.forCondition(subject!.isBefore(expected)).failWith(
            '$subjectLabel\n    $subject\nshould not be before\n    $expected\n    but does.',
          );
    } else {
      Execute.assertion.forCondition(!subject!.isBefore(expected)).failWith(
            '$subjectLabel\n    $subject\nshould be before\n    $expected\n    but does not.',
          );
    }

    return DateTimeAssertions(subject);
  }

  @override
  DateTimeAssertions copy(
    DateTime? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) {
    return DateTimeAssertions(
      subject,
      isReversed: isReversed,
      subjectLabel: subjectLabel,
    );
  }
}
