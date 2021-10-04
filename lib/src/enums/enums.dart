import 'package:shouldly/src/base_assertions.dart';

/// Contains Enum's extension methods for custom assertions in unit tests.
extension EnumExtension on Enum {
  /// Returns an `EnumAssertions` object that can be used to assert the
  /// current `Enum` />.
  EnumAssertions get should => EnumAssertions(this);
}

/// Contains a number of methods to assert that a `Enum` is in the expected state.
class EnumAssertions extends BaseAssertions<Enum, EnumAssertions> {
  /// Initializes a new instance of the `EnumAssertions` class.
  EnumAssertions(
    Enum? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) : super(subject, isReversed: isReversed, subjectLabel: subjectLabel);

  @override
  EnumAssertions copy(
    Enum? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) {
    return EnumAssertions(
      subject,
      isReversed: isReversed,
      subjectLabel: subjectLabel,
    );
  }
}
