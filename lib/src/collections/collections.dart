import 'package:collection/collection.dart';
import 'package:shouldly/src/base_assertions.dart';
import 'package:shouldly/src/exception.dart';

final _eq = const ListEquality().equals;

/// Contains Iterable's extension methods for custom assertions in unit tests.
extension IterableExtensions<T> on Iterable<T>? {
  /// Returns an `IterableAssertions` object that can be used to assert the
  /// current `Iterable` />.
  IterableAssertions<T> get should => IterableAssertions<T>(this);
}

/// Contains a number of methods to assert that a `Iterable` is in the expected state.
class IterableAssertions<T>
    extends BaseAssertions<Iterable<T>, IterableAssertions<T>> {
  /// Initializes a new instance of the `BoolAssertions` class.
  IterableAssertions(
    Iterable<T>? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) : super(subject, isReversed: isReversed, subjectLabel: subjectLabel);

  @override
  IterableAssertions<T> be(Object value) {
    final isEqual = _eq(subject!.toList(), value as List);
    if (isReversed) {
      if (isEqual) {
        throw ShouldlyTestFailure(
          '\n$subjectLabel collection\n    `$subject`\nshould not be equal to\n    `$value`',
        );
      }
    } else {
      if (!isEqual) {
        throw ShouldlyTestFailure(
          '\n$subjectLabel collection\n    `$subject`\nshould be equal to\n    `$value`',
        );
      }
    }

    return IterableAssertions<T>(subject);
  }

  /// Asserts that the collection does not contain any items.
  IterableAssertions<T> get beEmpty {
    if (isReversed) {
      if (subject!.isEmpty) {
        throw ShouldlyTestFailure('Iterable should be empty');
      }
    } else {
      if (subject!.isNotEmpty) {
        throw ShouldlyTestFailure('Iterable should be empty');
      }
    }

    return IterableAssertions(subject);
  }

  /// Asserts that the number of items in the collection matches the supplied [expected] amount.
  IterableAssertions<T> haveCount(int expected) {
    if (isReversed) {
      if (subject!.length == expected) {
        throw ShouldlyTestFailure(
          'Current length ${subject!.length} is not equal to $expected.',
        );
      }
    } else {
      if (subject!.length != expected) {
        throw ShouldlyTestFailure(
          'Current length ${subject!.length} is not equal to $expected.',
        );
      }
    }

    return IterableAssertions(subject);
  }

  /// Expects the current collection to contain the specified element.
  IterableAssertions<T> contain(T expected) {
    if (isReversed) {
      if (subject!.contains(expected)) {
        throw ShouldlyTestFailure(
          '$subjectLabel\n    $subject\nshould not contain\n    $expected\nbut does',
        );
      }
    } else {
      if (!subject!.contains(expected)) {
        throw ShouldlyTestFailure(
          '$subjectLabel\n    $subject\nshould contain\n    $expected\nbut does not',
        );
      }
    }

    return IterableAssertions(subject);
  }

  /// Expects the current collection to contain the specified elements.
  IterableAssertions<T> containAll(Iterable<T> expected) {
    if (isReversed) {
      if (subject!.toSet().containsAll(expected)) {
        throw ShouldlyTestFailure(
          '\n$subjectLabel iterable\n    $subject\nshould not contain all items of\n    $expected\nbut it does',
        );
      }
      return IterableAssertions(subject);
    } else {
      if (!subject!.toSet().containsAll(expected)) {
        throw ShouldlyTestFailure(
          '\n$subjectLabel iterable\n    $subject\nshould contain all items of\n    $expected\nbut it does not',
        );
      }
    }

    return IterableAssertions(subject);
  }

  ///
  IterableAssertions<T> all(void Function(T item) predicate) {
    if (isReversed) {
      throw ShouldlyTestFailure('Please change expression without `not`.');
    }

    for (var i = 0; i < subject!.length; i++) {
      predicate(subject!.elementAt(i));
    }

    return IterableAssertions(subject);
  }

  /// Asserts that the collection contains items that matches the predicate.
  IterableAssertions<T> every(bool Function(T item) predicate) {
    if (isReversed) {
      throw ShouldlyTestFailure('Please change expression without `not`.');
      // return Cap(value).any(predicate);
    }

    for (var i = 0; i < subject!.length; i++) {
      final element = subject!.elementAt(i);
      if (!predicate(element)) {
        throw Exception('$element in index $i is invalid');
      }
    }

    return IterableAssertions<T>(subject, isReversed: isReversed);
  }

  /// Asserts that the collection contains at least one item that matches the predicate.
  IterableAssertions<T> any(bool Function(T item) predicate) {
    if (isReversed) {
      throw ShouldlyTestFailure('Please change expression without `not`.');
      // return Cap(value).every(predicate);
    }

    for (var i = 0; i < subject!.length; i++) {
      final element = subject!.elementAt(i);
      if (predicate(element)) {
        return IterableAssertions<T>(subject, isReversed: isReversed);
      }
    }

    throw ShouldlyTestFailure('No any element there');
  }

  @override
  IterableAssertions<T> copy(
    Iterable<T>? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) {
    return IterableAssertions<T>(
      subject,
      isReversed: isReversed,
      subjectLabel: subjectLabel,
    );
  }
}
