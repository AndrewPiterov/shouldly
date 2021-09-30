import 'package:shouldly/src/cap.dart';

extension BoolExtensions on bool {
  Cap<bool> get should => Cap<bool>(this);
}

extension BoolCapExtension on Cap<bool> {
  Cap<bool> beTrue() {
    if (isReversed) {
      if (target) {
        throw Exception('\nTarget value should not be True');
      }
    } else {
      if (!target) {
        throw Exception('\nTarget value should be True');
      }
    }

    return Cap(target);
  }

  Cap<bool> beFalse() {
    if (isReversed) {
      if (!target) {
        throw Exception('\nTarget value should not be False');
      }
    } else {
      if (target) {
        throw Exception('\nTarget value should be False');
      }
    }

    return Cap(target);
  }
}
