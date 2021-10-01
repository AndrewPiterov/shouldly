import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

void main() {
  test('Boolean should be type of `bool`', () {
    true.should.beOfType<bool>();
  });

  test('Int should be type of `int`', () {
    10.should.beOfType<int>();
  });

  test('Int should be assignable to type `num`', () {
    10.should.beAssignableTo<num>();
  });

  test('Int should be type of `int`', () {
    10.should.beOfType<int>();
  });

  test('Double should be type of `double`', () {
    10.0.should.beOfType<double>();
  });

  test('Double should be type of `double`', () {
    10.0.should.beOfType<double>();
  });

  test('Double should be assignable to type `num`', () {
    10.0.should.beAssignableTo<num>();
  });

  group('some gr', () {
    test('list of Int should be type of `List<int>`', () {
      final list = [1, 2, 3];
      list.should.beOfType<List<int>>();
    });
  });

  test('list of Int should be type of `Iterable<int>`', () {
    [1, 2, 3].should.beAssignableTo<Iterable<int>>();
  });

  test('list of Int should be type of `List<int>`', () {
    [1, 2, 3].should.beOfType<List<int>>();
  });

  test('list of Strings should be type of `List<String>`', () {
    ['yes', 'no'].should.beOfType<List<String>>();
  });

  test('list of Strings should be assignable to type `Iterable<String>`', () {
    ['yes', 'no'].should.beAssignableTo<Iterable<String>>();
  });

  test('list with different types of objects should be type of `List<Object>`',
      () {
    [1, 'two', true].should.beOfType<List<Object>>();
  });

  test('String should not be type of `num`', () {
    'Some string'.should.not.beAssignableTo<num>();
  });

  group('description', () {
    test(
        'list with different types of objects should be assignable to type `Iterable<Object>`',
        () {
      [1, 'two', true].should.beAssignableTo<Iterable<Object>>();
    });
    test('Boolean Should not be type of `num`', () {
      true.should.not.beAssignableTo<num>();
    });
  });

  test('iterable should not be type of `num`', () {
    [].should.not.beAssignableTo<num>();
  });
}
