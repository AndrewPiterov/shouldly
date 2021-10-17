import 'package:collection/collection.dart';
import 'package:shouldly/shouldly.dart';
import 'package:shouldly/src/base_assertions.dart';
import 'package:shouldly/src/exception.dart';
import 'package:shouldly/src/execute_assertion.dart';

final _eq = const DeepCollectionEquality().equals;

/// Contains Map's extension methods for custom assertions in unit tests.
extension MapExtensions<TKey, TValue> on Map<TKey, TValue> {
  /// Returns an `MapAssertions` object that can be used to assert the
  /// current `map` />.
  MapAssertions<TKey, TValue> get should => MapAssertions<TKey, TValue>(this);

  /// Give a name to subject object
  MapAssertions<TKey, TValue> shouldAs(String label) =>
      MapAssertions<TKey, TValue>(this, subjectLabel: label);
}

/// Contains a number of methods to assert that a `Map` is in the expected state.
class MapAssertions<TKey, TValue>
    extends BaseAssertions<Map<TKey, TValue>, MapAssertions<TKey, TValue>> {
  /// Initializes a new instance of the `MapAssertions` class.
  MapAssertions(
    Map<TKey, TValue>? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) : super(subject, isReversed: isReversed, subjectLabel: subjectLabel);

  /// Asserts that the number of items in the dictionary matches the supplied [expected] amount.
  /// [expected] The expected number of items.
  MapAssertions haveCount(int expected) {
    if (isReversed) {
      Execute.assertion.forCondition(subject!.length == expected).failWith(
            '$subjectLabel should not have\n    $expected items\nbut does',
          );
    } else {
      Execute.assertion.forCondition(subject!.length != expected).failWith(
            '$subjectLabel should have\n    $expected items\nbut has\n    ${subject!.length}',
          );
    }

    return MapAssertions(subject);
  }

  /// Asserts that the dictionary does not contain any items.
  MapAssertions beEmpty() {
    if (isReversed) {
      Execute.assertion.forCondition(subject!.isEmpty).failWith(
            '$subjectLabel should not be empty\n    but does',
          );
    } else {
      Execute.assertion.forCondition(subject!.isNotEmpty).failWith(
            '$subjectLabel should be empty\nbut has count\n    ${subject!.length}',
          );
    }

    return MapAssertions(subject);
  }

  /// Asserts that the dictionary contains the specified key. Keys are compared using
  /// their `object` implementation.
  MapAssertions containKey(String key) {
    if (isReversed) {
      if (subject!.containsKey(key)) {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel map should not contain the key\n    `$key`\nbut it does',
        );
      }
    } else {
      if (!subject!.containsKey(key)) {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel map should has contain the key\n    `$key`\nbut it does not',
        );
      }
    }

    return MapAssertions(subject);
  }

  /// Asserts that the dictionary contains all of the specified keys. Keys are compared using
  /// their `Object` implementation.
  MapAssertions containKeys(Iterable<Object> expected) {
    if (isReversed) {
      Execute.assertion
          .forCondition(
            expected.every((element) => subject!.keys.contains(element)),
          )
          .failWith(
            '$subjectLabel map should not contain the keys\n    `$expected`\nbut it does.',
          );
    } else {
      Execute.assertion
          .forCondition(
            expected.any((element) => !subject!.keys.contains(element)),
          )
          .failWith(
            '$subjectLabel map should have contain the keys\n    `$expected`\nbut it does not\n    ${subject!.keys}',
          );
    }

    return MapAssertions(subject);
  }

  /// Asserts that the dictionary contains a value (not null) in specified key.
  MapAssertions haveValueInKey(String key) {
    if (!subject!.containsKey(key)) {
      throw ShouldlyTestFailureError('\n$subjectLabel has contain key `$key`');
    }

    if (isReversed) {
      if (subject![key] != null) {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel should not have value in key `$key`',
        );
      }
    } else {
      if (subject![key] == null) {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel should has some value in key `$key`',
        );
      }
    }
    return MapAssertions(subject);
  }

  /// Asserts that the dictionary contains the specified value in specified key.
  MapAssertions containKeyWithValue(dynamic key, dynamic value) {
    if (!subject!.containsKey(key)) {
      throw ShouldlyTestFailureError('\n$subjectLabel has contain key `$key`');
    }

    if (isReversed) {
      if (subject![key] == value) {
        throw ShouldlyTestFailureError(
          '$subjectLabel map\n  should not have exact value\n`$value`\n  in key\n`$key`\nbut does',
        );
      }
    } else {
      if (subject![key] != value) {
        throw ShouldlyTestFailureError(
          '\n$subjectLabel should has exact value `$value` in key `$key`',
        );
      }
    }

    return MapAssertions(subject);
  }

  /// Asserts that the dictionary contains the specified values in specified keys.
  MapAssertions contain(Iterable<MapEntry<Object, Object?>> expected) {
    final failedEntries = {};
    if (isReversed) {
      for (final entry in expected) {
        if (subject!.containsKey(entry.key)) {
          failedEntries.addEntries([entry]);
          continue;
        }

        if (subject![entry.key] == entry.value) {
          failedEntries.addEntries([entry]);
          continue;
        }
      }

      if (failedEntries.isNotEmpty) {
        throw ShouldlyTestFailureError(
          '$subjectLabel\n    $subject\nshould not contain\n    $failedEntries',
        );
      }
    } else {
      for (final entry in expected) {
        if (!subject!.containsKey(entry.key)) {
          failedEntries.addEntries([entry]);
          continue;
        }

        if (subject![entry.key] != entry.value) {
          failedEntries.addEntries([entry]);
          continue;
        }
      }

      if (failedEntries.isNotEmpty) {
        throw ShouldlyTestFailureError(
          '$subjectLabel\n    $subject\nshould contain\n    $failedEntries',
        );
      }
    }

    return MapAssertions(subject);
  }

  /// Asserts that the current dictionary contains all the same key-value pairs as the
  /// specified [expected] dictionary. Keys and values are compared using
  /// their [Object] implementation.
  @override
  MapAssertions<TKey, TValue> be(Object expected) {
    if (isReversed) {
      if (_eq(subject, expected)) {
        throw ShouldlyTestFailureError(
          '$subjectLabel map should be\n  `$expected`\nbut was\n  `$subject`',
        );
      }
    } else {
      if (!_eq(subject, expected)) {
        throw ShouldlyTestFailureError(
          '$subjectLabel map should be\n  `$expected`\nbut was\n  `$subject`',
        );
      }
    }

    return MapAssertions(subject);
  }

  @override
  bool eq(Map<TKey, TValue> expected) {
    return _eq(subject, expected);
  }

  @override
  MapAssertions<TKey, TValue> copy(
    Map<TKey, TValue>? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) {
    return MapAssertions(
      subject,
      isReversed: isReversed,
      subjectLabel: subjectLabel,
    );
  }
}
