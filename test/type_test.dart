import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

void main() {
  test('Boolean should be type of `bool`', () {
    true.should.beTypeOf<bool>();
  });

  test('Int should be type of `num`', () {
    10.should.beTypeOf<num>();
  });

  test('Int should be type of `int`', () {
    10.should.beTypeOf<int>();
  });

  test('Double should be type of `double`', () {
    10.0.should.beTypeOf<double>();
  });

  test('Double should be type of `num`', () {
    10.0.should.beTypeOf<num>();
  });

  test('list of Int should be type of `Iterable<int>`', () {
    [1, 2, 3].should.beTypeOf<Iterable<int>>();
  });

  test('list of Int should be type of `List<int>`', () {
    [1, 2, 3].should.beTypeOf<List<int>>();
  });

  test('list of Strings should be type of `Iterable<String>`', () {
    ['yes', 'no'].should.beTypeOf<Iterable<String>>();
  });

  test(
      'list with different types of objects should be type of `Iterable<Object>`',
      () {
    [1, 'two', true].should.beTypeOf<Iterable<Object>>();
  });

  test('String should not be type of `num`', () {
    'Some string'.should.not.beTypeOf<num>();
  });

  test('Boolean Should not be type of `num`', () {
    true.should.not.beTypeOf<num>();
  });

  test('iterable should not be type of `num`', () {
    [].should.not.beTypeOf<num>();
  });
}
