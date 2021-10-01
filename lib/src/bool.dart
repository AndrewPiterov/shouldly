import 'package:shouldly/src/base_assertions.dart';
import 'package:shouldly/src/eva_condition.dart';

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
  BoolAssertions(bool? target, {bool isReversed = false, String? targetLabel})
      : super(target, isReversed: isReversed, targetLabel: targetLabel);

  /// Asserts that the value is `true`
  BoolAssertions beTrue() {
    final eval = EvalCondition(
      condition: (x) => x! == true,
      target: target,
      errorMessage: '\n$targetLabel should be `true`',
      errorMessageForReverse: '\n$targetLabel should not be `true`',
    );

    eval.eval(isReversed: isReversed);

    return BoolAssertions(target);
  }

  /// Asserts that the value is `false`
  BoolAssertions beFalse() {
    final eval = EvalCondition(
      condition: (x) => x! == false,
      target: target,
      errorMessage: '\n$targetLabel should be `false`',
      errorMessageForReverse: '\n$targetLabel should not be `false`',
    );

    eval.eval(isReversed: isReversed);

    return BoolAssertions(target);
  }

  @override
  BoolAssertions copy(
    bool? target, {
    bool isReversed = false,
    String? targetLabel,
  }) {
    return BoolAssertions(
      target,
      isReversed: isReversed,
      targetLabel: targetLabel,
    );
  }
}
