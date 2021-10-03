import 'package:shouldly/shouldly.dart';
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

    test('should be odd', () {
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
  });
}
