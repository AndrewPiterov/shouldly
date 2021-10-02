import 'package:shouldly/shouldly_collection.dart';
import 'package:shouldly/shouldly_num.dart';
import 'package:test/test.dart';

void main() {
  test('compare empty lists', () {
    [].should.be([]);
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
    [].should.beEmpty;
  });

  test('should not be empty', () {
    ['yes'].should.not.beEmpty;
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

  test('with every elements whic satisfy condition', () {
    [3, 5, 7, 9].should.all((item) => item.should.beOdd());
  });

  // test('all numbers are odd', () {
  //   [3, 5, 7, 9].should.not.all((item) => item.should.beOdd());
  // });

  test('should has length', () {
    [30, 500, 70, 2].should.haveCount(4);
  });

  test('should not has wrong length', () {
    [30, 500, 70, 2].should.not.haveCount(5).and.not.beEmpty;
  });

  test('empty list has length of 0', () {
    [].should.haveCount(0).and.beEmpty;
  });

  test('empty list does not have length of 1', () {
    [].should.not.haveCount(1).and.beEmpty;
  });

  test('nullable list should be null', () {
    const List<String>? nullableList = null;
    nullableList.should.beNull();
  });
}
