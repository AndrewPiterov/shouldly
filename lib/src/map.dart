import 'package:collection/collection.dart';
import 'package:shouldly/src/cap.dart';
import 'package:shouldly/src/exception.dart';

final _eq = const DeepCollectionEquality().equals;

extension MapExtensions on Map? {
  ///
  /// Starting point to verify your conditions
  ///
  MapCap get should => MapCap(this);
}

class MapCap extends Cap<Map, MapCap> {
  MapCap(Map? target, {bool isReversed = false, String? targetLabel})
      : super(target, isReversed: isReversed, targetLabel: targetLabel);

  @override
  MapCap beEqual(Object value) {
    if (isReversed) {
      return MapCap(target, isReversed: !isReversed);
    }

    if (value != target) {
      if (!_eq(target, value)) {
        throw ShouldlyTestFailure(
          '$targetLabel map should be\n  `$value`\nbut was\n  `$target`',
        );
      }
    }

    return MapCap(target);
  }

  MapCap containKey(String key) {
    if (isReversed) {
      if (target!.containsKey(key)) {
        throw ShouldlyTestFailure(
          '\n$targetLabel map should not contain the key\n    `$key`\nbut it does',
        );
      }
    } else {
      if (!target!.containsKey(key)) {
        throw ShouldlyTestFailure(
          '\n$targetLabel map should has contain the key\n    `$key`\nbut it does not',
        );
      }
    }

    return MapCap(target, isReversed: isReversed);
  }

  MapCap hasValueInKey(String key) {
    if (!target!.containsKey(key)) {
      throw ShouldlyTestFailure('\n$targetLabel has contain key `$key`');
    }

    if (isReversed) {
      if (target![key] != null) {
        throw ShouldlyTestFailure(
          '\n$targetLabel should not have value in key `$key`',
        );
      }
    } else {
      if (target![key] == null) {
        throw ShouldlyTestFailure(
          '\n$targetLabel should has some value in key `$key`',
        );
      }
    }
    return MapCap(target, isReversed: isReversed);
  }

  MapCap containKeyWithValue(dynamic key, dynamic value) {
    if (!target!.containsKey(key)) {
      throw ShouldlyTestFailure('\n$targetLabel has contain key `$key`');
    }

    if (isReversed) {
      if (target![key] == value) {
        throw ShouldlyTestFailure(
          '$targetLabel map\n  should not have exact value\n`$value`\n  in key\n`$key`\nbut does',
        );
      }
    } else {
      if (target![key] != value) {
        throw ShouldlyTestFailure(
          '\n$targetLabel should has exact value `$value` in key `$key`',
        );
      }
    }

    return MapCap(target, isReversed: isReversed);
  }

  @override
  MapCap copy(Map? target, {bool isReversed = false, String? targetLabel}) {
    return MapCap(
      target,
      isReversed: isReversed,
      targetLabel: targetLabel,
    );
  }
}
