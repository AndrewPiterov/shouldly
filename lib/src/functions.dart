import 'package:shouldly/src/cap.dart';

extension FunctionExtensions on Function {
  Cap<Function> get should => Cap<Function>(this);
}

class FunctionExecutionException implements Exception {
  final String cause;
  FunctionExecutionException(this.cause);
}

extension FunctionCapExtensions on Cap<Function> {
  void throwException() {
    try {
      target.call();
      throw FunctionExecutionException(
          'The function has not thowed any exception');
    } catch (e) {
      if (e is FunctionExecutionException) {
        rethrow;
      }
    }
  }

  void throwExact<T extends Exception>() {
    try {
      target.call();
      throw FunctionExecutionException(
          'The function has not thowed any exception');
    } catch (e) {
      if (e is FunctionExecutionException) {
        rethrow;
      }

      if (e is! T) {
        throw Exception('Should throw the axception of exact type <$T>');
      }
    }
  }

  void notThrowException() {
    try {
      target.call();
    } catch (e) {
      throw Exception('Should not throw any axception');
    }
  }
}
