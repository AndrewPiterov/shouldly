import 'package:shouldly/src/cap.dart';

extension BoolExtensions on bool {
  Cap<bool> get should => Cap<bool>(this);
}

extension BoolCapExtension on Cap<bool> {
  void beTrue() {
    if (isReversed) {
      if (target) {
        throw Exception('Value should not be True');
      }
      return;
    }

    if (!target) {
      throw Exception('Value should be True');
    }
  }

  void beFalse() {
    if (isReversed) {
      if (!target) {
        throw Exception('Value should not be False');
      }
      return;
    }

    if (target) {
      throw Exception('Value should be False');
    }
  }

  void notBeFalse() {
    if (!target) {
      throw Exception('Value should be True');
    }
  }
}
