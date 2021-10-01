import 'package:collection/collection.dart';
import 'package:shouldly/src/cap.dart';
import 'package:shouldly/src/exception.dart';

final _eq = const ListEquality().equals;

extension IterableExtensions<T> on Iterable<T>? {
  IterableCap<T> get should => IterableCap<T>(this);
}

class IterableCap<T> extends Cap<Iterable<T>, IterableCap<T>> {
  IterableCap(
    Iterable<T>? target, {
    bool isReversed = false,
    String? targetLabel,
  }) : super(target, isReversed: isReversed, targetLabel: targetLabel);

  @override
  IterableCap<T> beEqual(Object value) {
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

    return IterableCap<T>(target);
  }

  @override
  IterableCap<T> copy(
    Iterable<T>? target, {
    bool isReversed = false,
    String? targetLabel,
  }) {
    return IterableCap<T>(
      target,
      isReversed: isReversed,
      targetLabel: targetLabel,
    );
  }

  IterableCap<T> beEmpty() {
    if (isReversed) {
      if (target!.isEmpty) {
        throw ShouldlyTestFailure('Iterable should be empty');
      }
    } else {
      if (target!.isNotEmpty) {
        throw ShouldlyTestFailure('Iterable should be empty');
      }
    }

    return IterableCap(target);
  }

  IterableCap<T> hasLenght(int length) {
    if (isReversed) {
      if (target!.length == length) {
        throw ShouldlyTestFailure(
          'Current length ${target!.length} is not equal to $length.',
        );
      }
    } else {
      if (target!.length != length) {
        throw ShouldlyTestFailure(
          'Current length ${target!.length} is not equal to $length.',
        );
      }
    }

    return IterableCap(target);
  }

  IterableCap<T> contain(T item) {
    if (isReversed) {
      if (target!.contains(item)) {
        throw ShouldlyTestFailure(
          '$targetLabel\n    $target\nshould not contain\n    $item\nbut does',
        );
      }
    } else {
      if (!target!.contains(item)) {
        throw ShouldlyTestFailure(
          '$targetLabel\n    $target\nshould contain\n    $item\nbut does not',
        );
      }
    }

    return IterableCap(target);
  }

  IterableCap<T> containAll(Iterable<T> items) {
    if (isReversed) {
      if (target!.toSet().containsAll(items)) {
        throw ShouldlyTestFailure(
          '\n$targetLabel iterable\n    $target\nshould not contain all items of\n    $items\nbut it does',
        );
      }
      return IterableCap(target);
    } else {
      if (!target!.toSet().containsAll(items)) {
        throw ShouldlyTestFailure(
          '\n$targetLabel iterable\n    $target\nshould contain all items of\n    $items\nbut it does not',
        );
      }
    }

    return IterableCap(target);
  }

  IterableCap<T> all(void Function(T item) predicate) {
    if (isReversed) {
      throw ShouldlyTestFailure('Please change expression without `not`.');
    }

    for (var i = 0; i < target!.length; i++) {
      predicate(target!.elementAt(i));
    }

    return IterableCap(target);
  }

  IterableCap<T> every(bool Function(T item) predicate) {
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

    return IterableCap<T>(target, isReversed: isReversed);
  }

  IterableCap<T> any(bool Function(T item) predicate) {
    if (isReversed) {
      throw ShouldlyTestFailure('Please change expression without `not`.');
      // return Cap(value).every(predicate);
    }

    for (var i = 0; i < target!.length; i++) {
      final element = target!.elementAt(i);
      if (predicate(element)) {
        return IterableCap<T>(target, isReversed: isReversed);
      }
    }

    throw ShouldlyTestFailure('No any element there');
  }
}
