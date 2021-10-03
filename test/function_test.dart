import 'package:shouldly/shouldly.dart';
import 'package:shouldly/shouldly_function.dart';
import 'package:test/test.dart';

void main() {
  test('should throw any exception', () {
    throwException.should.throwException();
  });

  test('should not throw throw an exception', () {
    someMethod.should.not.throwException();
  });

  test('should throw exact type of exception', () {
    throwExactException.should.throwException<CustomException>();
  });

  test('should throw exact type of error', () {
    throwExactCustomError.should.throwError<CustomError>();
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

  group('throw error -', () {
    test('should not throw error', () {
      Should.throwError<ShouldlyTestFailureError>(
        () => someMethod.should.throwError(),
      );
    });

    test('should throw errro but ', () {
      Should.throwError<ShouldlyTestFailureError>(
        () => throwException.should.not.throwError(),
      );
    });
  });

  group('throw exception -', () {
    test('should not throw exception', () {
      final error = Should.throwError<ShouldlyTestFailureError>(
        () => someMethod.should.throwException(),
      );

      error.message.should.be('subject function does not throw exception');
      error.toString().should.be('subject function does not throw exception');
    });

    test('should throw exception but ', () {
      Should.throwError<ShouldlyTestFailureError>(
        () => throwException.should.not.throwException(),
      );
    });
  });

  group('discover error parameter -', () {
    test('should throw exact error', () {
      final error = throwExactCustomError.should.throwError<CustomError>();
      error!.reason.should.be('Some reason');
    });
  });
}

class CustomException implements Exception {
  String cause;
  CustomException(this.cause);
}

class CustomError extends Error {
  final String reason;

  CustomError(this.reason);
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

void throwError() {
  throw Error();
}

void throwExactCustomError() {
  throw CustomError('Some reason');
}

void someMethod() {
  return;
}
