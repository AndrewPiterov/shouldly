import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

void main() {
  test('should throw any exception', () {
    Should.throwException(() => throwException());
  });

  test('should throw an exception (2)', () {
    expect(
      () => Should.throwException(() => someMethodWithArgs()),
      throwsException,
    );
  });

  test('should not throw throw an exception', () {
    Should.notThrowException(() => someMethodWithArgs(a: 100));
  });

  test('should throw exact type of exception', () {
    Should.throwException<CustomException>(() => throwExactException());
  });

  test('should throw exact type of error', () {
    Should.throwError<CustomError>(() => throwExactCustomError());
  });

  test('should throw an error (2)', () {
    expect(
      () => Should.throwError(() => someMethodWithArgs()),
      throwsException,
    );
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
      const Duration(seconds: 2),
      func: () => slowFunction(
        const Duration(seconds: 1),
      ),
    );
  });

  test('should complete after a period of time', () async {
    await Should.completeAfter(
      const Duration(seconds: 3),
      func: () => slowFunction(
        const Duration(seconds: 4),
      ),
    );
  });

  group('discover error parameter -', () {
    test('should throw exact error', () {
      final error =
          Should.throwError<CustomError>(() => throwExactCustomError());
      error.reason.should.be('Some reason');
    });
  });

  group('function with args', () {
    test('should throw excception', () {
      Should.throwException(() => throwExactExceptionWithArgs(''));
    });

    test('should not throw excception', () {
      Should.notThrowException(() => someMethodWithArgs(a: 3));
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

void throwExactExceptionWithArgs(String arg) {
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

int someMethodWithArgs({int a = 0}) {
  return a;
}
