import 'package:shouldly/src/cap.dart';
import 'package:shouldly/src/exception.dart';

extension NumExtensions on num {
  NumberCap get should => NumberCap(this);
}

class NumberCap extends Cap<num, NumberCap> {
  NumberCap(num? target, {bool isReversed = false, String? targetLabel})
      : super(target, isReversed: isReversed, targetLabel: targetLabel);

  NumberCap beOdd() {
    if (isReversed) {
      return NumberCap(target).beEven();
    }

    if (target! % 2 == 0) {
      throw ShouldlyTestFailure('$target is not odd');
    }

    return NumberCap(target);
  }

  NumberCap beEven() {
    if (isReversed) {
      return NumberCap(target).beOdd();
    }

    if (target! % 2 != 0) {
      throw ShouldlyTestFailure('$target is not even');
    }

    return NumberCap(target);
  }

  NumberCap beGreaterThan(num value) {
    if (isReversed) {
      if (target! > value) {
        throw ShouldlyTestFailure(
          '\n$targetLabel number\n    $target\nshould not greater than\n    $value',
        );
      }
    } else {
      if (target! <= value) {
        throw ShouldlyTestFailure(
          '\n$targetLabel number\n    $target\nshould be greater than\n    $value',
        );
      }
    }

    return NumberCap(target);
  }

  NumberCap beAbove(num value) {
    return beGreaterThan(value);
  }

  NumberCap beLessThan(num value) {
    if (isReversed) {
      if (target! < value) {
        throw ShouldlyTestFailure(
          '\n$targetLabel number\n    $target\nshould not less than\n    $value',
        );
      }
    } else {
      if (target! >= value) {
        throw ShouldlyTestFailure(
          '\n$targetLabel number\n    $target\nshould be less than\n    $value',
        );
      }
    }

    return NumberCap(target);
  }

  NumberCap beBelow(num value) {
    return beLessThan(value);
  }

  NumberCap beGreaterOrEqualThan(num value) {
    if (isReversed) {
      return NumberCap(target).beLessOrEqualThan(value);
    }

    if (target! < value) {
      throw ShouldlyTestFailure('$target less than $value');
    }

    return NumberCap(target);
  }

  NumberCap beLessOrEqualThan(num value) {
    if (isReversed) {
      return NumberCap(target).beGreaterOrEqualThan(value);
    }

    final m = value + 1;
    if (target! > m) {
      throw ShouldlyTestFailure('$target is not less than $m');
    }

    return NumberCap(target);
  }

  NumberCap beWithin(num min, num max) {
    if (isReversed) {
      if (target! < max && target! > min) {
        throw ShouldlyTestFailure(
          '\n$targetLabel number\n    $target\nshould not be within\n    [$min, $max]',
        );
      }
    } else {
      if (target! > max || target! < min) {
        throw ShouldlyTestFailure(
          '\n$targetLabel number\n    $target\nshould be within\n    [$min, $max]',
        );
      }
    }

    return NumberCap(target);
  }

  @override
  NumberCap copy(num? target, {bool isReversed = false, String? targetLabel}) {
    return NumberCap(
      target,
      isReversed: isReversed,
      targetLabel: targetLabel,
    );
  }
}
