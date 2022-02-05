// ignore_for_file: avoid_print

import 'package:shouldly/src/exception.dart';

// ignore: avoid_classes_with_only_static_members
///Static class for shoulds
class Should {
  /// Expects the function to throw Exception
  static T? throwException<T extends Exception>(Function() func) {
    try {
      func();

      throw FunctionExecutionException(
        '\nsubject function does not throw an exception',
      );
    } catch (e) {
      if (e is FunctionExecutionException) {
        throw FunctionExecutionException(
          'subject function does not throw an exception',
        );
      }

      if (e is T) {
        return e;
      } else {
        final message =
            'subject function does not throw exact exception of `$T`';
        print(message);
        throw FunctionExecutionException(message);
      }
    }
  }

  /// Expects the function to throw Exception
  static T? notThrowException<T extends Exception>(Function() func) {
    try {
      func();
    } catch (e) {
      if (e is FunctionExecutionException) {
        throw FunctionExecutionException(
          'subject function does not throw exception',
        );
      }

      if (e is T) {
        return e;
      } else {
        final message =
            'subject function does not throw exact exception of `$T`';
        print(message);
        throw FunctionExecutionException(message);
      }
    }
  }

  /// Expects the function to throw Exception
  static T throwError<T extends Error>(Function() func) {
    try {
      func();

      throw FunctionExecutionException(
        '\nsubject function does not throw exception',
      );
    } catch (e) {
      if (e is FunctionExecutionException) {
        throw FunctionExecutionException(
          'subject function does not throw exception',
        );
      }

      if (e is T) {
        return e;
      } else {
        final message =
            'subject function does not throw exact exception of `$T`';
        print(message);
        throw FunctionExecutionException(message);
      }
    }
  }

  /// Expects the function to throw Exception
  static T? notThrowError<T extends Error>(Function() func) {
    try {
      func();
    } catch (e) {
      if (e is FunctionExecutionException) {
        throw FunctionExecutionException(
          'subject function does not throw exception',
        );
      }

      if (e is T) {
        return e;
      } else {
        final message = 'subject function does not throw exact error of `$T`';
        print(message);
        throw FunctionExecutionException(message);
      }
    }
  }

  /// Expects the function to throw Exception
  static Future throwAsync<T extends Exception>(Function() func) async {
    try {
      await func();

      throw FunctionExecutionException(
        '\nsubject function does not throw exception',
      );
    } catch (e) {
      if (e is FunctionExecutionException) {
        throw FunctionExecutionException(
          'subject function does not throw exception',
        );
      }

      if (e is T) {
        // good catch
      } else {
        final message =
            'subject function does not throw exact exception of `$T`';
        print(message);
        throw FunctionExecutionException(message);
      }
    }
  }

  /// Check that the function should not throw any exception
  static Future notThrowAsync(Function() func) async {
    try {
      await func();
    } catch (e) {
      final message =
          'subject function should not throw any exception\n    but threw\n${e.toString()}';
      print(message);
      throw FunctionExecutionException(message);
    }
  }

  /// Check that the function should complte execution in a duration
  static Future<Duration> completeIn(
    Duration duration, {
    required Function() func,
    bool shouldSkipThrowException = false,
  }) async {
    final stopwatch = Stopwatch()..start();
    await func();

    final elapsed = stopwatch.elapsed;

    if (elapsed > duration && !shouldSkipThrowException) {
      print('the function executed in $elapsed');
      final actualExecutionTimeInMilliseconds =
          stopwatch.elapsed.inMilliseconds - duration.inMilliseconds;
      throw ShouldlyTestFailureError(
        'Expected function should be complited in ${duration.inMilliseconds} ms\n    but execution took more than\n$actualExecutionTimeInMilliseconds ms',
      );
    }

    return elapsed;
  }

  /// Check that the function should complte execution after period of time
  static Future<Duration> completeAfter(
    Duration duration, {
    required Function() func,
    bool shouldSkipThrowException = false,
  }) async {
    final stopwatch = Stopwatch()..start();
    await func();

    final elapsed = stopwatch.elapsed;

    if (elapsed < duration && !shouldSkipThrowException) {
      print('the function executed in $elapsed');
      final actualExecutionTimeInMilliseconds =
          stopwatch.elapsed.inMilliseconds - duration.inMilliseconds;
      throw ShouldlyTestFailureError(
        'Expected function should be complited after ${duration.inMilliseconds} ms\n    but execution took less than\n$actualExecutionTimeInMilliseconds ms',
      );
    }

    return elapsed;
  }

  ///
  static void shouldSatisfyAllConditions(List<Function()> conditions) {
    //
    final fails = <String>[];
    for (final c in conditions) {
      try {
        c();
      } on ShouldlyTestFailureError catch (error) {
        fails.add(error.message!);
      } on Exception catch (e) {
        final err = e.toString();
        fails.add(err);
      }
    }

    if (fails.isNotEmpty) {
      final buffer = StringBuffer();
      buffer.write(
        'Expected satisfy all conditions specified, but doe not.\nThe following errors were found ...\n',
      );
      for (var i = 0; i < fails.length; i++) {
        final fail = fails[i];
        buffer.write('------------- Error ${i + 1} -------------\n');
        buffer.write(fail);
        buffer.write('\n\n');
      }

      buffer.write('------------------------------------\n');
      throw ShouldlyTestFailureError(buffer.toString());
    }
  }
}

///
class FunctionExecutionException implements Exception {
  ///
  final String cause;

  ///
  FunctionExecutionException(this.cause);
}
