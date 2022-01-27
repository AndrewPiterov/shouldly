import 'package:shouldly/shouldly.dart';

/// Contains String's extension methods for custom assertions in unit tests.
extension StringExtensions on String? {
  /// Returns an `StringAssertions` object that can be used to assert the
  /// current `String` />.
  StringAssertions get should => StringAssertions(this);
}

/// Contains a number of methods to assert that a `String` is in the expected state.
class StringAssertions extends BaseAssertions<String, StringAssertions> {
  /// Initializes a new instance of the `StringAssertion` class.
  StringAssertions(
    String? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) : super(subject, isReversed: isReversed, subjectLabel: subjectLabel);

  /// Asserts that a string starts exactly with the specified [expected] value,
  /// including the casing and any leading or trailing whitespace.
  ///
  /// [expected] The string that the subject is expected to start with.
  StringAssertions startWith(String expected) {
    if (isReversed) {
      if (subject!.startsWith(expected)) {
        throw ShouldlyTestFailureError(
          '\nExpected $subjectLabel\n    `$subject`\nto not start with\n    `$expected`\nbut it does',
        );
      }
    } else {
      if (!subject!.startsWith(expected)) {
        throw ShouldlyTestFailureError(
          '\nExpected $subjectLabel\n    `$subject`\nto start with\n    `$expected`\nbut it does not',
        );
      }
    }

    return StringAssertions(subject);
  }

  /// Asserts that a string ends exactly with the specified [expected] value,
  /// including the casing and any leading or trailing whitespace.
  ///
  /// [expected] The string that the subject is expected to end with.
  StringAssertions endWith(String expected) {
    if (isReversed) {
      if (subject!.endsWith(expected)) {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel string\n    `$subject`\nshould not end with\n    `$expected`\nbut it does',
        );
      }
    } else {
      if (!subject!.endsWith(expected)) {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel string\n    `$subject`\nshould end with\n    `$expected`\nbut it does not',
        );
      }
    }

    return StringAssertions(subject);
  }

  /// Asserts that a string has the specified [expected] length.
  /// [expected] The expected length of the string
  StringAssertions haveLength(int expected) {
    if (isReversed) {
      if (subject!.length == expected) {
        throw ShouldlyTestFailureError(
          "String length of '$subject' is $expected chars",
        );
      }
      return StringAssertions(subject, isReversed: isReversed);
    }

    if (subject!.length != expected) {
      throw ShouldlyTestFailureError(
        'String length of `$subject` is not $expected chars',
      );
    }

    return StringAssertions(subject, isReversed: isReversed);
  }

  /// Asserts that a string is either `null` or `''` />.
  StringAssertions beNullOrEmpty() {
    if (isReversed) {
      if (subject == null || subject == '') {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel string\n    `$subject`\nshould not be null or empty',
        );
      }
      return StringAssertions(subject);
    } else {
      if (subject != null && subject != '') {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel string\n    `$subject`\nshould be null or empty',
        );
      }
    }

    return copy(subject);
  }

  /// Asserts that a string is either `null` or `''` or white space
  StringAssertions beNullOrWhiteSpace() {
    if (isReversed) {
      Execute.assertion
          .forCondition(subject == null || subject!.trim().isEmpty)
          .failWith(
            'Expected String should not be <null> or whitespace, but found `$subject`.',
          );
    } else {
      Execute.assertion
          .forCondition(subject != null && subject!.trim().isNotEmpty)
          .failWith(
            'Expected String should be <null> or whitespace, but found `$subject`.',
          );
    }

    return copy(subject);
  }

  /// Asserts that a string is either `''` or white space
  StringAssertions beBlank() {
    final trimmed = subject!.trim();
    if (isReversed) {
      if (trimmed.isEmpty) {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel\n    `$subject`\nshould not be blank\n    but does',
        );
      }
      return StringAssertions(subject);
    } else {
      if (trimmed.isNotEmpty) {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel\n    `$subject`\nshould be blank\n    but does not',
        );
      }
    }

    return StringAssertions(subject, isReversed: isReversed);
  }

  /// Asserts that a string matches a wildcard pattern.
  /// [wildcardPattern]
  /// The wildcard pattern with which the subject is matched, where * and ? have special meanings.
  StringAssertions match(String wildcardPattern) {
    final regExp = RegExp(wildcardPattern);
    if (isReversed) {
      if (regExp.hasMatch(subject!)) {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel string\n  `$subject`\nshould not match\n    `$wildcardPattern`\nbut does',
        );
      }
    } else {
      if (!regExp.hasMatch(subject!)) {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel string\n  `$subject`\nshould match\n    `$wildcardPattern`\nbut it does not',
        );
      }
    }

    return StringAssertions(subject, isReversed: isReversed);
  }

  ///
  StringAssertions contain(String expected, {bool ignoreCase = false}) {
    final a = (ignoreCase ? subject?.toLowerCase() : subject) ?? '';
    final e = ignoreCase ? expected.toLowerCase() : expected;

    final contains = a.contains(e);

    final caseSensitivity = ignoreCase
        ? 'case insensitive comparison'
        : 'case sensitive comparison';

    if (isReversed) {
      if (contains) {
        throw ShouldlyTestFailureError(
          '\nExpected $subjectLabel\n    "$subject"\nto not contain ($caseSensitivity)\n    "$expected"\nbut it does',
        );
      }
    } else {
      if (!contains) {
        throw ShouldlyTestFailureError(
          '\nExpected $subjectLabel\n    "$subject"\nto contain ($caseSensitivity)\n    "$expected"\nbut it does not',
        );
      }
    }

    return StringAssertions(subject, isReversed: isReversed);
  }

  @override
  StringAssertions copy(
    String? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) {
    return StringAssertions(
      subject,
      isReversed: isReversed,
      subjectLabel: subjectLabel,
    );
  }
}
