import 'package:shouldly/src/exception.dart';
import 'package:shouldly/src/functions.dart';

class Should {
  static Future throwAsync<T extends Exception>(Function func) async {
    try {
      await func();

      throw FunctionExecutionException(
          '\nTarget function does not throw exception');
    } catch (e) {
      if (e is FunctionExecutionException) {
        throw FunctionExecutionException(
            'target function does not throw exception');
      }

      if (e is T) {
        // good catch
      } else {
        final message =
            'target function does not throw exact exception of `$T`';
        print(message);
        throw FunctionExecutionException(message);
      }
    }
  }

  static Future notThrowAsync(Function func) async {
    try {
      await func();
    } catch (e) {
      final message =
          'target function should not throw any exception\n    but threw\n${e.toString()}';
      print(message);
      throw FunctionExecutionException(message);
    }
  }

  static Future completeIn(
    Duration duration, {
    required Function func,
  }) async {
    final stopwatch = Stopwatch()..start();
    await func();

    final elapsed = stopwatch.elapsed;

    if (elapsed > duration) {
      print('the function executed in ${elapsed}');
      final ms = stopwatch.elapsed.inMilliseconds - duration.inMilliseconds;
      throw ShouldlyTestFailure(
          'the function should be complited in ${duration.inMilliseconds} ms\n    but execution took more\n$ms ms');
    }
  }
}
