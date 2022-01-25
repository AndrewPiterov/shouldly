import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

void main() {
  test('compare empty lists', () {
    [].should.be([]);
  });

  group('throw error -', () {
    test('when compare different list', () {
      Should.throwError<ShouldlyTestFailureError>(() => [].should.be([1]));
    });

    test('when compare same list with not', () {
      Should.throwError<ShouldlyTestFailureError>(() => [].should.not.be([]));
    });

    group('be empty', () {
      test('should be empty', () {
        Should.throwError<ShouldlyTestFailureError>(() => [1].should.beEmpty());
      });

      test('should not be empty', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => [].should.not.beEmpty(),
        );
      });
    });

    group('have count', () {
      test('should have count', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => [1].should.haveCount(2),
        );
      });

      test('should not have count', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => [].should.not.haveCount(0),
        );
      });
    });

    group('contain', () {
      test('should contain', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => [1].should.contain(2),
        );
      });

      test('should not contain', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => [1].should.not.contain(1),
        );
      });
    });

    group('contain all', () {
      test('should contain all', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => [1, 2].should.containAll([3, 4]),
        );
      });

      test('should not contain all', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => [1, 2].should.not.containAll([1, 2]),
        );
      });
    });

    group('any -', () {
      test('should have any element', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => [1, 2].should.any((e) => e > 100),
        );
      });

      test('should not have any element', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => [1, 2].should.not.any((e) => e < 10),
        );
      });
    });

    group('every -', () {
      test('should have every element', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => [1, 2].should.every((e) => e > 10),
        );
      });

      test('should not have every element', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => [1, 2].should.not.every((e) => e > 10),
        );
      });
    });
  });

  test('compare non empty equal lists', () {
    [1, 2, 3].should.be([1, 2, 3]);
  });

  test('compare non nullable and non empty to equal lists', () {
    [1, 2, 3].should.not.contain(4).and.be([1, 2, 3]);
  });

  test('compare non nullable and non empty to equal lists 2', () {
    [1, 2, 3].should.as('myList').not.beNull().and.be([1, 2, 3]);
  });

  test('compare non empty non equal lists', () {
    [1, 2, 3].should.not.be([1, 2, 4]);
  });

  test('should be empty', () {
    [].should.beEmpty();
  });

  test('should not be empty', () {
    ['yes'].should.not.beEmpty();
  });

  test('should contain', () {
    [1, 200, 3].should.contain(200);
  });

  test('should not contain', () {
    [1, 200, 3].should.not.contain(4);
  });

  test('with every element in collection is true for predicate', () {
    [3, 5, 7, 9].should.every((item) => item < 10);
  });

  // test('NOT every element in collection is true for predicate', () {
  //   [3, 5, 7, 9].should.not.every((item) => item < 8);
  // });

  test('with some elements in collection is true for predicate', () {
    [3, 5, 7, 9].should.any((item) => item > 8);
  });

  // test('some element in collection is true for predicate', () {
  //   [3, 5, 7, 9].should.not.any((item) => item >= 10);
  // });

  group('all', () {
    test('with every elements whic satisfy condition', () {
      [3, 5, 7, 9].should.all((item) => item.should.beOdd());
    });

    // test('all numbers are odd', () {
    //   [3, 5, 7, 9].should.not.all((item) => item.should.beOdd());
    // });

    test('should not have all element', () {
      Should.throwError<ShouldlyTestFailureError>(
        () => [1, 2].should.not.all((e) => e > 10),
      );
    });
  });

  test('should has length', () {
    [30, 500, 70, 2].should.haveCount(4);
  });

  test('should not has wrong length', () {
    [30, 500, 70, 2].should.not.haveCount(5).and.not.beEmpty();
  });

  test('empty list has length of 0', () {
    [].should.haveCount(0).and.beEmpty();
  });

  test('empty list does not have length of 1', () {
    [].should.not.haveCount(1).and.beEmpty();
  });

  test('nullable list should be null', () {
    const List<String>? nullableList = null;
    nullableList.should.beNull();
  });

  group('contain all', () {
    test('should contain all', () {
      [1, 2].should.containAll([1, 2]);
    });

    test('should not contain all', () {
      [1, 2].should.not.containAll([3, 4]);
    });
  });

  group('One of item in an Array', () {
    test('array contain the List', () {
      [1, 2].should.beOneOf([
        [1, 2],
        [3, 4]
      ]);
    });

    test('array does not contain the List', () {
      [1, 2].should.not.beOneOf([
        [3, 4],
        [5, 6]
      ]);
    });
  });
}
