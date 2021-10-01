import 'package:collection/collection.dart';
import 'package:shouldly/src/base_assertions.dart';
import 'package:shouldly/src/exception.dart';

final _eq = const ListEquality().equals;

///
extension IterableExtensions<T> on Iterable<T>? {
  ///
  IterableAssertions<T> get should => IterableAssertions<T>(this);
}

///
class IterableAssertions<T>
    extends BaseAssertions<Iterable<T>, IterableAssertions<T>> {
  ///
  IterableAssertions(
    Iterable<T>? target, {
    bool isReversed = false,
    String? targetLabel,
  }) : super(target, isReversed: isReversed, targetLabel: targetLabel);

  @override
  IterableAssertions<T> be(Object value) {
    final isEqual = _eq(target!.toList(), value as List);
    if (isReversed) {
      if (isEqual) {
        throw ShouldlyTestFailure(
          '\n$targetLabel collection\n    `$target`\nshould not be equal to\n    `$value`',
        );
      }
    } else {
      if (!isEqual) {
        throw ShouldlyTestFailure(
          '\n$targetLabel collection\n    `$target`\nshould be equal to\n    `$value`',
        );
      }
    }

    return IterableAssertions<T>(target);
  }

  /// Asseet
  IterableAssertions<T> beEmpty() {
    if (isReversed) {
      if (target!.isEmpty) {
        throw ShouldlyTestFailure('Iterable should be empty');
      }
    } else {
      if (target!.isNotEmpty) {
        throw ShouldlyTestFailure('Iterable should be empty');
      }
    }

    return IterableAssertions(target);
  }

  ///
  IterableAssertions<T> hasLenght(int expectedLength) {
    if (isReversed) {
      if (target!.length == expectedLength) {
        throw ShouldlyTestFailure(
          'Current length ${target!.length} is not equal to $expectedLength.',
        );
      }
    } else {
      if (target!.length != expectedLength) {
        throw ShouldlyTestFailure(
          'Current length ${target!.length} is not equal to $expectedLength.',
        );
      }
    }

    return IterableAssertions(target);
  }

  /// Expects the current collection to contain the specified element.
  IterableAssertions<T> contain(T expected) {
    if (isReversed) {
      if (target!.contains(expected)) {
        throw ShouldlyTestFailure(
          '$targetLabel\n    $target\nshould not contain\n    $expected\nbut does',
        );
      }
    } else {
      if (!target!.contains(expected)) {
        throw ShouldlyTestFailure(
          '$targetLabel\n    $target\nshould contain\n    $expected\nbut does not',
        );
      }
    }

    return IterableAssertions(target);
  }

  /// Expects the current collection to contain the specified elements.
  IterableAssertions<T> containAll(Iterable<T> expected) {
    if (isReversed) {
      if (target!.toSet().containsAll(expected)) {
        throw ShouldlyTestFailure(
          '\n$targetLabel iterable\n    $target\nshould not contain all items of\n    $expected\nbut it does',
        );
      }
      return IterableAssertions(target);
    } else {
      if (!target!.toSet().containsAll(expected)) {
        throw ShouldlyTestFailure(
          '\n$targetLabel iterable\n    $target\nshould contain all items of\n    $expected\nbut it does not',
        );
      }
    }

    return IterableAssertions(target);
  }

  ///
  IterableAssertions<T> all(void Function(T item) predicate) {
    if (isReversed) {
      throw ShouldlyTestFailure('Please change expression without `not`.');
    }

    for (var i = 0; i < target!.length; i++) {
      predicate(target!.elementAt(i));
    }

    return IterableAssertions(target);
  }

  ///
  IterableAssertions<T> every(bool Function(T item) predicate) {
    if (isReversed) {
      throw ShouldlyTestFailure('Please change expression without `not`.');
      // return Cap(value).any(predicate);
    }

    for (var i = 0; i < target!.length; i++) {
      final element = target!.elementAt(i);
      if (!predicate(element)) {
        throw Exception('$element in index $i is invalid');
      }
    }

    return IterableAssertions<T>(target, isReversed: isReversed);
  }

  ///
  IterableAssertions<T> any(bool Function(T item) predicate) {
    if (isReversed) {
      throw ShouldlyTestFailure('Please change expression without `not`.');
      // return Cap(value).every(predicate);
    }

    for (var i = 0; i < target!.length; i++) {
      final element = target!.elementAt(i);
      if (predicate(element)) {
        return IterableAssertions<T>(target, isReversed: isReversed);
      }
    }

    throw ShouldlyTestFailure('No any element there');
  }

  @override
  IterableAssertions<T> copy(
    Iterable<T>? target, {
    bool isReversed = false,
    String? targetLabel,
  }) {
    return IterableAssertions<T>(
      target,
      isReversed: isReversed,
      targetLabel: targetLabel,
    );
  }
}
