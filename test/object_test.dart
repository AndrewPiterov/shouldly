import 'package:shouldly/shouldly_object.dart';
import 'package:test/test.dart';

void main() {
  test('should be not null', () {
    final obj = Object();
    obj.should.not.beNull();
  });

  test('should be null', () {
    const Object? obj = null;
    obj.should.beNull();
  });

  test('should be type of `Object`', () {
    final obj = Object();
    obj.should.beOfType<Object>();
  });

  test('should be type of `int`', () {
    const obj = 1;
    obj.should.beOfType<int>();
  });

  test('should be assignable to `num`', () {
    const obj = 1;
    obj.should.beAssignableTo<num>();
  });

  // TODO: check on null
  // test('should be type of `Object`', () {
  //   final Object? obj = null;
  //   obj.should.beOfType<Object>();
  // });
}
