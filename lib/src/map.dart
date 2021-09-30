import 'package:shouldly/src/cap.dart';
import 'package:collection/collection.dart';

final _eq = DeepCollectionEquality().equals;

extension MapExtensions on Map {
  ///
  /// Starting point to verify your conditions
  ///
  MapCap get should => MapCap(this);
}

class MapCap extends Cap<Map> {
  MapCap(Map target, {bool isReversed = false})
      : super(target, isReversed: isReversed);

  @override
  MapCap be(Object value) {
    if (isReversed) {
      return MapCap(this.target);
    }

    if (value != this.target) {
      if (!_eq(this.target, value)) {
        throw Exception(
            'target map should be\n  `$value`\nbut was\n  `${this.target}`');
      }
    }

    return MapCap(this.target);
  }
}

extension MapCapExtensions on Cap<Map> {
  MapCap containKey(String key) {
    if (isReversed) {
      if (target.containsKey(key)) {
        throw Exception(
            'target map should not contain the key\n    `$key`\nbut it does');
      }
    } else {
      if (!target.containsKey(key)) {
        throw Exception(
            'target map should has contain the key\n    `$key`\nbut it does not');
      }
    }

    return MapCap(target, isReversed: isReversed);
  }

  MapCap hasValueInKey(String key) {
    if (!target.containsKey(key)) {
      throw Exception('target has contain key `$key`');
    }

    if (isReversed) {
      if (target[key] != null) {
        throw Exception('target should not have value in key `$key`');
      }
    } else {
      if (target[key] == null) {
        throw Exception('target should has some value in key `$key`');
      }
    }
    return MapCap(target, isReversed: isReversed);
  }

  MapCap containKeyWithValue(dynamic key, dynamic value) {
    if (!target.containsKey(key)) {
      throw Exception('target has contain key `$key`');
    }

    if (isReversed) {
      if (target[key] == value) {
        throw Exception(
            'target\n  should not have exact value\n`$value`\n  in key\n`$key`\nbut does');
      }
    } else {
      if (target[key] != value) {
        throw Exception('target should has exact value `$value` in key `$key`');
      }
    }

    return MapCap(target, isReversed: isReversed);
  }
}
