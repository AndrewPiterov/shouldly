import 'package:shouldly/shouldly.dart';

void main() {
  (-10).should.beNegative;
  // ignore: avoid_print
  print('Done');
}

extension CustomNumAssertions on NumericAssertions {
  NumericAssertions get beNegative {
    if (target! >= 0) {
      throw Exception('Value\n  should be negative\n  but was\n$target');
    }
    return NumericAssertions(target);
  }
}
