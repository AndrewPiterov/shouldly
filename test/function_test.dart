import 'package:shouldly/shouldly.dart';
import 'package:shouldly/shouldly_function.dart';
import 'package:test/test.dart';

void main() {
  test('should throw any exception', () {
    throwException.should.throwException();
  });

  test('should not throw throw an exception', () {
    someMethod.should.notThrowException();
  });

  test('should throw exact type of exception', () {
    throwExactException.should.throwExact<CustomException>();
  });

  test('async function should throw exception', () async {
    await Should.throwAsync(() {
      Future.delayed(const Duration(milliseconds: 100));
      throw Exception('test');
    });
  });

  test('async function should not throw exception', () async {
    await Should.notThrowAsync(() {
      Future.delayed(const Duration(milliseconds: 100));
    });
  });

  test('async function should throw exact exception', () async {
    await Should.throwAsync<CustomException>(() {
      Future.delayed(const Duration(milliseconds: 100));
      throw CustomException('custom execption test');
    });
  });

  test('should complete in a duration', () async {
    await Should.completeIn(
      const Duration(seconds: 1),
      func: () => slowFunction(
        const Duration(milliseconds: 900),
      ),
    );
  });
}

class CustomException implements Exception {
  String cause;
  CustomException(this.cause);
}

Future asyncFunction() async {
  throw CustomException('test');
}

Future slowFunction(Duration duration) async {
  await Future.delayed(duration);
}

void throwException() {
  throw Exception();
}

void throwExactException() {
  throw CustomException('test');
}

void someMethod() {
  return;
}
