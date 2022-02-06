import 'package:collection/collection.dart';
import 'package:shouldly/shouldly.dart';

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
  }) : super(
          subject,
          isReversed: isReversed,
          subjectLabel: subjectLabel,
        );

  @override
  IterableAssertions<T> be(Object expected) {
    final diff = _compare(expected as Iterable, subject!);
    final isEqual = diff.every((d) => !d.isDiff);
    if (isReversed) {
      if (isEqual) {
        throw ShouldlyTestFailureError(
          '\nExpected $subjectLabel collection\n    `$subject` (${expected.runtimeType})\nshould not be equal to\n    `$expected` (${expected.runtimeType})',
        );
      }
    } else {
      if (!isEqual) {
        final diffArray = <String>[];
        for (final d in diff) {
          diffArray.add(
            d.isDiff
                ? d.expected == null
                    ? '*'
                    : '*${d.expected}*'
                : d.expected.toString(),
          );
        }

        final diffMessage = '\ndifference\n    $diffArray';

        final body =
            '\nExpected $subjectLabel collection\n    $subject (${expected.runtimeType})\nshould be equal to\n    $expected (${expected.runtimeType})';

        throw ShouldlyTestFailureError(body + diffMessage);
      }
    }

    return IterableAssertions<T>(subject);
  }

  List<_DiffItem> _compare(Iterable expected, Iterable actual) {
    final expectedIterator = expected.iterator;
    final actualIterator = actual.iterator;

    final difference = <_DiffItem>[];

    for (var index = 0;; index++) {
      // Advance in lockstep.
      final expectedNext = expectedIterator.moveNext();
      final actualNext = actualIterator.moveNext();

      // If we reached the end of both, we succeeded.
      if (!expectedNext && !actualNext) break;

      // Fail if their lengths are different.
      // var newLocation = '$location[$index]';
      if (!expectedNext) {
        if (actualNext) {
          // difference[index] = null;
          difference.add(
            _DiffItem(
              isDiff: true,
              expected: null,
              actual: actualIterator.current,
            ),
          );
        }

        continue; // _Mismatch.simple(newLocation, actual, 'longer than expected');
      }
      if (!actualNext) {
        if (expectedNext) {
          // difference[index] = expectedIterator.current;
          difference.add(
            _DiffItem(
              isDiff: true,
              expected: expectedIterator.current,
              actual: null, // actualIterator.current,
            ),
          );
        }
        continue;
        //  _Mismatch.simple(newLocation, actual, 'shorter than expected');
      }

      // Match the elements.
      // var rp = matcher(
      //     expectedIterator.current, actualIterator.current, newLocation, depth);
      // if (rp != null) return rp;
      if (expectedIterator.current != actualIterator.current) {
        final diff = <_DiffItem>[];
        if (expectedIterator.current is Iterable &&
            actualIterator.current is Iterable) {
          final x = _compare(
            expectedIterator.current as Iterable,
            actualIterator.current as Iterable,
          );
          diff.addAll(x);
        } else {
          diff.add(
            _DiffItem(
              isDiff: true,
              expected: expectedIterator.current,
              actual: actualIterator.current,
            ),
          );
        }

        if (diff.any((element) => element.isDiff)) {
          difference.add(
            _DiffItem(
              isDiff: true,
              expected: expectedIterator.current,
              actual: actualIterator.current,
            ),
          );
        }
      }

      difference.add(
        _DiffItem(
          isDiff: false,
          expected: expectedIterator.current,
          actual: actualIterator.current,
        ),
      );
    }

    return difference;
  }

  @override
  bool isEqual(Iterable<T> expected) {
    final e = _eq(expected.toList(), subject?.toList());
    return e;
    // final diff = _compare(expected, subject!);
    // return diff.any((element) => element.isDiff);
  }

  /// Asserts that the collection does not contain any items.
  IterableAssertions<T> beEmpty() {
    if (isReversed) {
      if (subject!.isEmpty) {
        throw ShouldlyTestFailureError(
          'Expected $subjectLabel to not be\n   $subject\nbut was\n    []',
        );
      }
    } else {
      if (subject!.isNotEmpty) {
        throw ShouldlyTestFailureError(
          'Expected $subjectLabel to be\n   []\nbut was\n    $subject',
        );
      }
    }

    return IterableAssertions(subject);
  }

  /// Asserts that the number of items in the collection matches the supplied [expected] amount.
  IterableAssertions<T> haveCount(int expected) {
    if (isReversed) {
      if (subject!.length == expected) {
        throw ShouldlyTestFailureError(
          'Current length ${subject!.length} is not equal to $expected.',
        );
      }
    } else {
      if (subject!.length != expected) {
        throw ShouldlyTestFailureError(
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
        throw ShouldlyTestFailureError(
          'Expected $subjectLabel\n${ShouldlySettings.pads}should not contain\n$expected\n${ShouldlySettings.pads}but was actually\n$subject',
        );
      }
    } else {
      if (!subject!.contains(expected)) {
        throw ShouldlyTestFailureError(
          'Expected $subjectLabel\n${ShouldlySettings.pads}should contain\n$expected\n${ShouldlySettings.pads}but was actually\n$subject',
        );
      }
    }

    return IterableAssertions(subject);
  }

  /// Expects the current collection to contain the specified elements.
  IterableAssertions<T> containAll(Iterable<T> expected) {
    if (isReversed) {
      if (subject!.toSet().containsAll(expected)) {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel iterable\n    $subject\nshould not contain all items of\n    $expected\nbut it does',
        );
      }
      return IterableAssertions(subject);
    } else {
      if (!subject!.toSet().containsAll(expected)) {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel iterable\n    $subject\nshould contain all items of\n    $expected\nbut it does not',
        );
      }
    }

    return IterableAssertions(subject);
  }

  ///
  IterableAssertions<T> all(void Function(T item) predicate) {
    if (isReversed) {
      throw ShouldlyTestFailureError('Please change expression without `not`.');
    }

    for (var i = 0; i < subject!.length; i++) {
      predicate(subject!.elementAt(i));
    }

    return IterableAssertions(subject);
  }

  /// Asserts that the collection contains items that matches the predicate.
  IterableAssertions<T> every(bool Function(T item) predicate) {
    if (isReversed) {
      throw ShouldlyTestFailureError('Please change expression without `not`.');
      // return Cap(value).any(predicate);
    }

    for (var i = 0; i < subject!.length; i++) {
      final element = subject!.elementAt(i);
      if (!predicate(element)) {
        throw ShouldlyTestFailureError('$element in index $i is invalid');
      }
    }

    return IterableAssertions<T>(subject);
  }

  /// Asserts that the collection contains at least one item that matches the predicate.
  IterableAssertions<T> any(bool Function(T item) predicate) {
    if (isReversed) {
      throw ShouldlyTestFailureError('Please change expression without `not`.');
      // return Cap(value).every(predicate);
    }

    for (var i = 0; i < subject!.length; i++) {
      final element = subject!.elementAt(i);
      if (predicate(element)) {
        return IterableAssertions<T>(subject);
      }
    }

    throw ShouldlyTestFailureError('No any element there');
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

class _DiffItem {
  _DiffItem({
    required this.isDiff,
    required this.expected,
    required this.actual,
  });

  final bool isDiff;
  final dynamic expected;
  final dynamic actual;

  @override
  String toString() => '$expected ${isDiff ? '!=' : '='} $actual';
}
