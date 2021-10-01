import 'package:shouldly/src/cap.dart';

extension BoolExtensions on bool? {
  BooleanCap get should => BooleanCap(this);
}

class BooleanCap extends Cap<bool, BooleanCap> {
  // ignore: avoid_positional_boolean_parameters
  BooleanCap(bool? target, {bool isReversed = false, String? targetLabel})
      : super(target, isReversed: isReversed, targetLabel: targetLabel);

  BooleanCap beTrue() {
    if (isReversed) {
      if (target!) {
        throw Exception('\n$targetLabel value should not be True');
      }
    } else {
      if (!target!) {
        throw Exception('\n$targetLabel value should be True');
      }
    }

    return BooleanCap(target);
  }

  BooleanCap beFalse() {
    if (isReversed) {
      if (!target!) {
        throw Exception('\n$targetLabel value should not be False');
      }
    } else {
      if (target!) {
        throw Exception('\n$targetLabel value should be False');
      }
    }

    return BooleanCap(target);
  }

  @override
  BooleanCap copy(
    bool? target, {
    bool isReversed = false,
    String? targetLabel,
  }) {
    return BooleanCap(target, isReversed: isReversed, targetLabel: targetLabel);
  }
}
