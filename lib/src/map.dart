import 'package:shouldly/src/cap.dart';

extension MapExtensions on Map {
  Cap<Map> get should => Cap<Map>(this);
}

extension MapCapExtensions on Cap<Map> {
  Cap<Map> containKey(String key) {
    if (isReversed) {
      if (target.containsKey(key)) {
        throw Exception('target has not contain key `$key`');
      }
    } else {
      if (!target.containsKey(key)) {
        throw Exception('target has contain key `$key`');
      }
    }

    return Cap(target, isReversed: isReversed);
  }

  Cap<Map> hasValueInKey(String key) {
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
    return Cap(target, isReversed: isReversed);
  }

  Cap<Map> containKeyWithValue(dynamic key, dynamic value) {
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

    return Cap(target, isReversed: isReversed);
  }
}
