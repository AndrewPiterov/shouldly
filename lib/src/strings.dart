import 'package:shouldly/src/base_assertions.dart';
import 'package:shouldly/src/exception.dart';

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
    String? target, {
    bool isReversed = false,
    String? targetLabel,
  }) : super(target, isReversed: isReversed, targetLabel: targetLabel);

  /// Asserts that a string starts exactly with the specified [expected] value,
  /// including the casing and any leading or trailing whitespace.
  ///
  /// [expected] The string that the subject is expected to start with.
  StringAssertions startWith(String expected) {
    if (isReversed) {
      if (target!.startsWith(expected)) {
        throw ShouldlyTestFailure(
          '\n$targetLabel string\n    `$target`\nshould not start with\n    `$expected`\nbut it does',
        );
      }
    } else {
      if (!target!.startsWith(expected)) {
        throw ShouldlyTestFailure(
          '\n$targetLabel string\n    `$target`\nshould end start\n    `$expected`\nbut it does not',
        );
      }
    }

    return StringAssertions(target);
  }

  /// Asserts that a string ends exactly with the specified [expected] value,
  /// including the casing and any leading or trailing whitespace.
  ///
  /// [expected] The string that the subject is expected to end with.
  StringAssertions endWith(String expected) {
    if (isReversed) {
      if (target!.endsWith(expected)) {
        throw ShouldlyTestFailure(
          '\n$targetLabel string\n    `$target`\nshould not end with\n    `$expected`\nbut it does',
        );
      }
    } else {
      if (!target!.endsWith(expected)) {
        throw ShouldlyTestFailure(
          '\n$targetLabel string\n    `$target`\nshould end with\n    `$expected`\nbut it does not',
        );
      }
    }

    return StringAssertions(target);
  }

  /// Check length of string
  StringAssertions hasLength(int length) {
    if (isReversed) {
      if (target!.length == length) {
        throw ShouldlyTestFailure(
          "String length of '$target' is $length chars",
        );
      }
      return StringAssertions(target, isReversed: isReversed);
    }

    if (target!.length != length) {
      throw ShouldlyTestFailure(
        'String length of `$target` is not $length chars',
      );
    }

    return StringAssertions(target, isReversed: isReversed);
  }

  /// Asserts that a string is either `null` or `''` />.
  StringAssertions get beNullOrEmpty {
    if (isReversed) {
      if (target == null || target == '') {
        throw ShouldlyTestFailure(
          '\n$targetLabel string\n    `$target`\nshould not be null or empty',
        );
      }
      return StringAssertions(target);
    } else {
      if (target != null && target != '') {
        throw ShouldlyTestFailure(
          '\n$targetLabel string\n    `$target`\nshould be null or empty',
        );
      }
    }

    return StringAssertions(target, isReversed: isReversed);
  }

  /// Asserts that a string is either `''` or white space
  StringAssertions get beBlank {
    final trimmed = target!.trim();
    if (isReversed) {
      if (trimmed.isEmpty) {
        throw ShouldlyTestFailure(
          '\n$targetLabel string\n    `$target`\nshould not be blank',
        );
      }
      return StringAssertions(target);
    } else {
      if (trimmed.isNotEmpty) {
        throw ShouldlyTestFailure(
          '\n$targetLabel string\n    `$target`\nshould be blank',
        );
      }
    }

    return StringAssertions(target, isReversed: isReversed);
  }

  /// Asserts that a string matches a wildcard pattern.
  /// [wildcardPattern]
  /// The wildcard pattern with which the subject is matched, where * and ? have special meanings.
  StringAssertions match(String wildcardPattern) {
    final regExp = RegExp(wildcardPattern);
    if (isReversed) {
      if (regExp.hasMatch(target!)) {
        throw ShouldlyTestFailure(
          '\n$targetLabel string\n  `$target`\nshould not match\n    `$wildcardPattern`\nbut does',
        );
      }
    } else {
      if (!regExp.hasMatch(target!)) {
        throw ShouldlyTestFailure(
          '\n$targetLabel string\n  `$target`\nshould match\n    `$wildcardPattern`\nbut it does not',
        );
      }
    }

    return StringAssertions(target, isReversed: isReversed);
  }

  @override
  StringAssertions copy(
    String? target, {
    bool isReversed = false,
    String? targetLabel,
  }) {
    return StringAssertions(
      target,
      isReversed: isReversed,
      targetLabel: targetLabel,
    );
  }
}
