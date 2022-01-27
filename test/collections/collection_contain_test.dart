import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('collection - contain -', () {
    const actual = [1, 2, 3, 5.0, 6, 7, 8, 9];
    test('should contain 5', () {
      actual.should.contain(5.0);
      actual.should.contain(5);
    });

    test('should not contain 4', () {
      actual.should.not.contain(4);
    });
  });
}
