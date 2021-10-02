import 'package:shouldly/shouldly_num.dart';
import 'package:test/test.dart';

void main() {
  group('Number -', () {
    test('comparison', () {
      2.should.be(2);
    });

    test('comparison (2)', () {
      2.should.not.be(3);
    });

    test('should be even', () {
      2.should.beEven();
    });

    test('should be odd', () {
      3.should.beOdd();
    });

    test('should be even and greater than', () {
      20.should.beEven().and.beGreaterThan(19);
    });

    test('should be odd and greater or equal than', () {
      19.should.beOdd().and.beGreaterOrEqualThan(19);
    });

    test('should be even and not greater than', () {
      2.should.beEven().and.not.beGreaterThan(3);
    });

    test('should be even and not less or equal than', () {
      10.should.beEven().and.not.beLessOrEqualThan(10);
    });

    test('should be odd and not less or equal than', () {
      7.should.beOdd().and.beLessOrEqualThan(7);
    });

    test('should not be even and not less or equal than', () {
      9.should.not.beEven().and.not.beLessOrEqualThan(8);
    });

    test('should be and not equal', () {
      7.5.should.be(7.5).and.not.be(0);
    });

    group('within -', () {
      test('number should be within a range', () {
        10.should.beWithin(9, 11);
      });

      test('number should be within a range in left adge', () {
        10.should.beWithin(10, 20);
      });

      test('number should be within a range in right adge', () {
        10.should.beWithin(1, 10);
      });

      test('number should not be within a range', () {
        10.should.not.beWithin(11, 20);
      });
    });
  });
}
