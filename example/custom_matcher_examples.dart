import 'package:shouldly/shouldly.dart';

void main() {
  (-10).should.beNegative;
  print('Done');
}

extension CE on NumberCap {
  NumberCap get beNegative {
    if (target! >= 0) {
      throw Exception('Value\n  should be negative\n  but was\n$target');
    }
    return NumberCap(target);
  }
}
