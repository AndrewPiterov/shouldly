import 'package:shouldly/src/cap.dart';
import 'package:shouldly/src/exception.dart';

extension NumExtensions on num {
  Cap<num> get should => Cap<num>(this);
}

extension NumCapExtensions on Cap<num> {
  Cap<num> beOdd() {
    if (isReversed) {
      return Cap(target).beEven();
    }

    if (target % 2 == 0) {
      throw Exception('$target is not odd');
    }

    return Cap<num>(target);
  }

  Cap<num> beEven() {
    if (isReversed) {
      return Cap(target).beOdd();
    }

    if (target % 2 != 0) {
      throw Exception('$target is not even');
    }

    return Cap<num>(target);
  }

  Cap<num> beGreaterThan(num value) {
    if (isReversed) {
      if (target > value) {
        throw Exception(
            'Target number\n    $target\nshould not greater than\n    $value');
      }
    } else {
      if (target <= value) {
        throw Exception(
            'Target number\n    $target\nshould be greater than\n    $value');
      }
    }

    return Cap<num>(target);
  }

  Cap<num> beAbove(num value) {
    return beGreaterThan(value);
  }

  Cap<num> beLessThan(num value) {
    if (isReversed) {
      if (target < value) {
        throw Exception(
            'Target number\n    $target\nshould not less than\n    $value');
      }
    } else {
      if (target >= value) {
        throw Exception(
            'Target number\n    $target\nshould be less than\n    $value');
      }
    }

    return Cap<num>(target);
  }

  Cap<num> beBelow(num value) {
    return beLessThan(value);
  }

  Cap<num> beGreaterOrEqualThan(num value) {
    if (isReversed) {
      return Cap(target).beLessOrEqualThan(value);
    }

    if (target < value) {
      throw Exception('$target less than $value');
    }

    return Cap<num>(target);
  }

  Cap<num> beLessOrEqualThan(num value) {
    if (isReversed) {
      return Cap(target).beGreaterOrEqualThan(value);
    }

    final m = value + 1;
    if (target > m) {
      throw Exception('$target is not less than $m');
    }

    return Cap<num>(target);
  }

  Cap<num> beWithin(num min, num max) {
    if (isReversed) {
      if (target < max && target > min) {
        throw Exception(
            '\nTarget number\n    $target\nshould not be within\n    [$min, $max]');
      }
    } else {
      if (target > max || target < min) {
        throw Exception(
            '\nTarget number\n    $target\nshould be within\n    [$min, $max]');
      }
    }

    return Cap<num>(target);
  }
}
