import 'dart:developer';

import 'package:shouldly/shouldly.dart';
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

    test('should not be odd', () {
      4.should.not.beOdd();
    });

    test('should be even and greater than', () {
      20.should.beGreaterThan(19).and.beEven();
    });

    test('should be greater or equal than', () {
      20.should.beGreaterOrEqualThan(20);
      20.should.beGreaterOrEqualThan(19);
    });

    test('should not be greater or equal than', () {
      20.should.not.beGreaterOrEqualThan(21);
    });

    test('should throw error when number should not be greater or equal than',
        () {
      // Should.throw()
      Should.throwError<ShouldlyTestFailureError>(
        () => 20.should.beGreaterOrEqualThan(21),
      );
    });

    test('should be odd and greater or equal than', () {
      19.should.beOdd().and.beGreaterOrEqualThan(19);
    });

    test('should be even and not greater than', () {
      2.should.not.beGreaterThan(3).and.beEven();
    });

    test('should be above', () {
      2.should.beAbove(1);
    });

    test('should be below', () {
      2.should.beBelow(3);
    });

    test('should be less than', () {
      10.should.beLessThan(11);
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

    group('beCloseTo', () {
      test('exact value should be close', () {
        10.0.should.beCloseTo(10.0, delta: 0);
      });

      test('value should be close', () {
        10.1.should.beCloseTo(10.0, delta: 0.1);
      });

      test('value should not be close', () {
        10.1.should.not.beCloseTo(10.0, delta: 0.09);
      });

      test('Sum', () {
        const a = 1.1;
        const b = 2.2;

        const sum = a + b;
        log('Sum of doubles: $sum');

        sum.should.not.be(3.3);
        sum.should.beCloseTo(3.3, delta: 0.0000000001);
      });
    });

    group('beToleratOf', () {
      test('max tolerance can be 1', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 10.should.beTolerantOf(10, tolerance: 1.1),
        );
      });

      test('min tolerance has to be greater than 0', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 10.should.beTolerantOf(100, tolerance: 0),
        );
      });

      test('value should be close', () {
        100.should.beTolerantOf(99, tolerance: 0.01);
        100.should.beTolerantOf(101, tolerance: 0.01);
      });

      test('value should not be close', () {
        100.should.not.beTolerantOf(98.999999999999, tolerance: 0.01);
        100.should.not.beTolerantOf(101.00000000000001, tolerance: 0.01);
        100.should.not.beTolerantOf(110, tolerance: 0.09999999999);
      });

      test('Sum', () {
        const a = 1.1;
        const b = 2.2;

        const sum = a + b;
        log('Sum of doubles: $sum');

        sum.should.not.be(3.3);
        sum.should.beTolerantOf(3.3, tolerance: 0.00001);
      });
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

    group('throw error -', () {
      test('be within', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 11.should.beWithin(0, 10),
        );
      });

      test('not be within', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 5.should.not.beWithin(0, 10),
        );
      });

      test('be less then', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 11.should.beLessThan(10),
        );
      });

      test('not be less then', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 5.should.not.beLessThan(10),
        );
      });

      test('be less or equal then', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 11.should.beLessOrEqualThan(10),
        );
      });

      test('not be less or equal then', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 1.should.not.beLessOrEqualThan(10),
        );
      });

      test('be greater then', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 5.should.beGreaterThan(10),
        );
      });

      test('not be greater then', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 20.should.not.beGreaterThan(10),
        );
      });
    });

    group('Positove', () {
      test('should be positive', () {
        1.should.bePositive();
      });

      test('0 should be positive', () {
        0.should.bePositive();
      });

      test('number less than 0 should not be positive', () {
        (-1).should.not.bePositive();
      });
    });

    group('Negative', () {
      test('should be negative', () {
        (-1).should.beNegative();
      });

      test('0 should be negative', () {
        0.should.not.beNegative();
      });

      test('number greater or equal than 0 should not be negative', () {
        1.should.not.beNegative();
      });
    });

    group('is Zero', () {
      test('should be 0', () {
        0.should.beZero();
      });

      test('number greater than 0 should not be 0', () {
        0.000001.should.not.beZero();
      });

      test('number greater less 0 should not be 0', () {
        (-0.0001).should.not.beZero();
      });
    });

    group('One of item in an Array', () {
      test('array contain number', () {
        10.should.beOneOf([1, 2, 3, 4, 10, 1, 30]);
      });

      test('array does not contain number', () {
        10.should.not.beOneOf([1, 2, 3, 4, -10, 1, 30]);
      });
    });
  });
}
