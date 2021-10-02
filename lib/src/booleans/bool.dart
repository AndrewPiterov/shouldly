import 'package:shouldly/src/base_assertions.dart';
import 'package:shouldly/src/execute_assertion.dart';

/// Contains boolean's extension methods for custom assertions in unit tests.
extension BoolExtensions on bool? {
  /// Returns an `BoolAssertions` object that can be used to assert the
  /// current `bool` />.
  BoolAssertions get should => BoolAssertions(this);
}

/// Contains a number of methods to assert that a `bool` is in the expected state.
class BoolAssertions extends BaseAssertions<bool, BoolAssertions> {
  /// Initializes a new instance of the `BoolAssertions` class.
  // ignore: avoid_positional_boolean_parameters
  BoolAssertions(bool? subject, {bool isReversed = false, String? subjectLabel})
      : super(subject, isReversed: isReversed, subjectLabel: subjectLabel);

  /// Asserts that the value is `true`
  BoolAssertions beTrue() {
    if (isReversed) {
      Execute.assertion
          .forCondition(subject == true)
          .failWith('$subjectLabel should not be `true`');
    } else {
      Execute.assertion
          .forCondition(subject == false)
          .failWith('$subjectLabel should be `true`');
    }

    return BoolAssertions(subject, subjectLabel: subjectLabel);
  }

  /// Asserts that the value is `false`
  BoolAssertions beFalse() {
    if (isReversed) {
      Execute.assertion
          .forCondition(subject == false)
          .failWith('$subjectLabel should not be `false`');
    } else {
      Execute.assertion
          .forCondition(subject == true)
          .failWith('$subjectLabel should be `false`');
    }

    return BoolAssertions(subject, subjectLabel: subjectLabel);
  }

  @override
  BoolAssertions copy(
    bool? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) {
    return BoolAssertions(
      subject,
      isReversed: isReversed,
      subjectLabel: subjectLabel,
    );
  }
}
