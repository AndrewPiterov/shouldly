import 'package:collection/collection.dart';
import 'package:shouldly/shouldly_function.dart';
import 'package:shouldly/src/cap.dart';
import 'package:shouldly/src/exception.dart';

Function _eq = const ListEquality().equals;

extension IterableExtensions<T> on Iterable<T> {
  IterableCap<T> get should => IterableCap<T>(this);
}

class IterableCap<T> extends Cap<Iterable<T>> {
  IterableCap(Iterable<T> target, {bool isReversed = false})
      : super(target, isReversed: isReversed);

  @override
  IterableCap<T> beEqual(Object value) {
    if (isReversed) {
      throw FunctionExecutionException('Not implemented');
    } else {
      if (value != this.target) {
        if (!_eq(this.target, value)) {
          throw ShouldlyTestFailure(
              '\nTarget collection should be\n  `$value`\nbut was\n  `$target`');
        }
      }
    }

    return IterableCap<T>(this.target);
  }
}

extension IterableCapExtensions<T> on Cap<Iterable<T>> {
  IterableCap<T> beEmpty() {
    if (isReversed) {
      if (target.isEmpty) {
        throw Exception('Iterable should be empty');
      }
    } else {
      if (target.isNotEmpty) {
        throw Exception('Iterable should be empty');
      }
    }

    return IterableCap(target);
  }

  IterableCap<T> hasLenght(int length) {
    if (isReversed) {
      if (target.length == length) {
        throw Exception(
            'Current length ${target.length} is not equal to $length.');
      }
    } else {
      if (target.length != length) {
        throw Exception(
            'Current length ${target.length} is not equal to $length.');
      }
    }

    return IterableCap(target);
  }

  IterableCap<T> contain(T item) {
    if (isReversed) {
      if (target.contains(item)) {
        throw ShouldlyTestFailure(
            '$targetLabel\n    $target\nshould not contain\n    $item\nbut does');
      }
    } else {
      if (!target.contains(item)) {
        throw ShouldlyTestFailure(
            '$targetLabel\n    $target\nshould contain\n    $item\nbut does not');
      }
    }

    return IterableCap(target);
  }

  IterableCap<T> containAll(Iterable<T> items) {
    if (isReversed) {
      if (target.toSet().containsAll(items)) {
        throw Exception(
            '\nTarget iterable\n    $target\nshould not contain all items of\n    $items\nbut it does');
      }
      return IterableCap(target);
    } else {
      if (!target.toSet().containsAll(items)) {
        throw Exception(
            '\nTarget iterable\n    $target\nshould contain all items of\n    $items\nbut it does not');
      }
    }

    return IterableCap(target);
  }

  IterableCap<T> all(void Function(T item) predicate) {
    if (isReversed) {
      throw Exception('Please change expression without `not`.');
    }

    for (var i = 0; i < target.length; i++) {
      predicate(target.elementAt(i));
    }

    return IterableCap(target);
  }

  Cap<Iterable<T>> every(bool Function(T item) predicate) {
    if (isReversed) {
      throw Exception('Please change expression without `not`.');
      // return Cap(value).any(predicate);
    }

    for (var i = 0; i < target.length; i++) {
      final element = target.elementAt(i);
      if (!predicate(element)) {
        throw Exception('$element in index $i is invalid');
      }
    }

    return Cap(target, isReversed: isReversed);
  }

  Cap<Iterable<T>> any(bool Function(T item) predicate) {
    if (isReversed) {
      throw Exception('Please change expression without `not`.');
      // return Cap(value).every(predicate);
    }

    for (var i = 0; i < target.length; i++) {
      final element = target.elementAt(i);
      if (predicate(element)) {
        return Cap(target, isReversed: isReversed);
      }
    }

    throw Exception('No any element there');
  }
}
