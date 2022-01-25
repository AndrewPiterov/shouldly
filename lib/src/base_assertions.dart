import 'package:shouldly/src/exception.dart';
import 'package:shouldly/src/execute_assertion.dart';

/// Base Matcher
abstract class BaseAssertions<T, K> {
  /// Matcher constructor
  BaseAssertions(
    this.subject, {
    this.isReversed = false,
    String? subjectLabel,
  }) : _subjectLabel = subjectLabel;

  /// the object which value is being asserted.
  final T? subject;

  /// Checking reverse
  final bool isReversed;

  final String? _subjectLabel;

  /// Friendly label for the subject object
  String get subjectLabel {
    if (_subjectLabel == null || _subjectLabel == '') {
      final x = '`${subject.runtimeType.toString()}`';
      return x;
    }

    return '`$_subjectLabel`';
  }

  /// Copy the matcher
  K copy(
    T? subject, {
    bool isReversed = false,
    String? subjectLabel,
  });

  /// Bind assertions
  K get and => copy(
        subject,
        isReversed: isReversed,
        subjectLabel: _subjectLabel,
      );

  /// Invert assertion
  K get not => copy(
        subject,
        isReversed: true,
        subjectLabel: _subjectLabel,
      );

  /// Set friendly title for the subject
  K as(String subjectLabel) => copy(
        subject,
        isReversed: isReversed,
        subjectLabel: subjectLabel,
      );

  /// Asserts that the value is equal to the specified [expected] value.
  /// [expected] The expected value
  K be(Object expected) {
    if (isReversed) {
      if (expected == subject) {
        throw ShouldlyTestFailureError(
          '\nExpected $subjectLabel to not be\n  `$expected`\nbut was\n  `$subject`',
        );
      }
    } else {
      if (expected != subject) {
        throw ShouldlyTestFailureError(
          '\nExpected $subjectLabel to be\n  `$expected`\nbut was\n  `$subject`',
        );
      }
    }

    return copy(subject, subjectLabel: subjectLabel);
  }

  /// Asserts that the object is not of the specified type `U`
  U? beOfType<U>() {
    final runtimeType = subject.runtimeType;
    final isNamesEqual = subject.runtimeType.toString() == U.toString();
    if (isReversed) {
      if (subject.runtimeType == U && isNamesEqual) {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel\n    $runtimeType\nshould not be an instantiation of Type\n    `$U`\nbut does',
        );
      }
    } else {
      if (subject.runtimeType != U && !isNamesEqual) {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel\n    $runtimeType\nshould be an instantiation of Type\n    `$U`\nbut does not',
        );
      }
    }

    try {
      final x = subject as U;
      return x;
    } catch (e) {
      // TODO: catch exact type cast error - example myIntNumber.should.not.beOfType<double>();
      return null;
    }
  }

  /// Asserts that the object is assignable to a variable of type `U`
  U? beAssignableTo<U>() {
    if (isReversed) {
      Execute.assertion.forCondition(subject is U).failWith(
            '$subjectLabel\n    $subject\nshould not be a subbclass of\n    `$U`\nbut does.',
          );
    } else {
      Execute.assertion.forCondition(subject is! U).failWith(
            '$subjectLabel\n    $subject\nshould be a subbclass of\n    `$U`\nbut does not',
          );
    }

    try {
      final x = subject as U;
      return x;
    } catch (e) {
      // TODO: catch exact type cast error - example with List<String/Int/etc>
      return null;
    }
  }

  /// Asserts that the object is not `null`
  K beNull() {
    if (isReversed) {
      Execute.assertion
          .forCondition(subject == null)
          .failWith('\nExpected $subjectLabel not to be <null>.');
    } else {
      Execute.assertion.forCondition(subject != null).failWith(
            '\nExpected $subjectLabel to be\n    <null>\nbut found\n    `${subject.runtimeType}` (Hashcode=${subject.hashCode})',
          );
    }

    return copy(subject, subjectLabel: _subjectLabel);
  }

  /// Asserts that a value is one of the specified [validItems]
  K beOneOf(Iterable<T> validItems) {
    if (isReversed) {
      Execute.assertion.forCondition(validItems.any((e) => eq(e))).failWith(
            '$subjectLabel\n    $subject\nshould not be one of\n    $validItems\nbut found.',
          );
    } else {
      Execute.assertion.forCondition(validItems.every((e) => !eq(e))).failWith(
            '$subjectLabel\n    $subject\nshould be one of\n    $validItems\nbut not found.',
          );
    }

    return copy(subject, subjectLabel: _subjectLabel);
  }

  /// Comparison with an another [expected] value
  bool eq(T expected) {
    return subject == expected;
  }
}
