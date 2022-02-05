import 'package:shouldly/src/base_assertions.dart';
import 'package:shouldly/src/execute_assertion.dart';

/// Contains Duration's extension methods for custom assertions in unit tests.
extension DurationExtension on Duration {
  /// Returns an `DurationAssertions` object that can be used to assert the
  /// current `Duration` />.
  DurationAssertions get should => DurationAssertions(this);
}

/// Contains a number of methods to assert that a `DateTime` is in the expected state.
class DurationAssertions extends BaseAssertions<Duration, DurationAssertions> {
  /// Initializes a new instance of the `DurationAssertions` class.
  DurationAssertions(Duration? subject) : super(subject);

  @override
  DurationAssertions copy(
    Duration? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) {
    throw UnimplementedError();
  }
}
