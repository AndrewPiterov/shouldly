// ignore_for_file: avoid_print

import 'package:shouldly/src/exception.dart';
import 'package:shouldly/src/functions/functions.dart';

// ignore: avoid_classes_with_only_static_members
///Static class for shoulds
class Should {
  /// Expects the function to throw Exception
  static Future throwAsync<T extends Exception>(Function func) async {
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
  static Future notThrowAsync(Function func) async {
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
  static Future completeIn(
    Duration duration, {
    required Function func,
  }) async {
    final stopwatch = Stopwatch()..start();
    await func();

    final elapsed = stopwatch.elapsed;

    if (elapsed > duration) {
      print('the function executed in $elapsed');
      final ms = stopwatch.elapsed.inMilliseconds - duration.inMilliseconds;
      throw ShouldlyTestFailure(
        'the function should be complited in ${duration.inMilliseconds} ms\n    but execution took more\n$ms ms',
      );
    }
  }
}
