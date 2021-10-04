import 'package:shouldly/src/base_assertions.dart';

/// Contains Object's extension methods for custom assertions in unit tests.
extension ObjectExtension on Object? {
  /// Returns an `ObjectAssertions` object that can be used to assert the
  /// current `Object` />.
  ObjectAssertions get should => ObjectAssertions(this);
}

/// Contains a number of methods to assert that a `Object` is in the expected state.
class ObjectAssertions extends BaseAssertions<Object, ObjectAssertions> {
  /// Initializes a new instance of the `ObjectAssertions` class.
  ObjectAssertions(
    Object? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) : super(subject, isReversed: isReversed, subjectLabel: subjectLabel);

  @override
  ObjectAssertions copy(
    Object? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) {
    return ObjectAssertions(
      subject,
      isReversed: isReversed,
      subjectLabel: subjectLabel,
    );
  }
}
