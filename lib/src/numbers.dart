import 'package:shouldly/src/cap.dart';

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

  Cap<num> beGreaterThan(int min) {
    if (isReversed) {
      return Cap(target).beLessThan(min);
    }

    if (target <= min) {
      throw Exception('$target is not greater than $min');
    }

    return Cap<num>(target);
  }

  Cap<num> beLessThan(int min) {
    if (isReversed) {
      return Cap(target).beGreaterThan(min);
    }

    if (target >= min) {
      throw Exception('$target is not less than $min');
    }

    return Cap<num>(target);
  }

  Cap<num> beGreaterOrEqualThan(int min) {
    if (isReversed) {
      return Cap(target).beLessOrEqualThan(min);
    }

    if (target < min) {
      throw Exception('$target less than $min');
    }

    return Cap<num>(target);
  }

  Cap<num> beLessOrEqualThan(int min) {
    if (isReversed) {
      return Cap(target).beGreaterOrEqualThan(min);
    }

    final m = min + 1;
    if (target > m) {
      throw Exception('$target is not less than $m');
    }

    return Cap<num>(target);
  }
}
