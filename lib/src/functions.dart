import 'package:shouldly/src/cap.dart';
import 'package:shouldly/src/exception.dart';

extension FunctionExtensions on Function {
  FunctionCap get should => FunctionCap(this);
}

class FunctionExecutionException implements Exception {
  final String cause;
  FunctionExecutionException(this.cause);
}

class FunctionCap extends Cap<Function, FunctionCap> {
  FunctionCap(Function? target, {bool isReversed = false, String? targetLabel})
      : super(target, isReversed: isReversed, targetLabel: targetLabel);

  void throwException() {
    try {
      target!.call();
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
      target!.call();
      throw FunctionExecutionException(
          'The function has not thowed any exception');
    } catch (e) {
      if (e is FunctionExecutionException) {
        rethrow;
      }

      if (e is! T) {
        throw ShouldlyTestFailure(
            'Should throw the axception of exact type <$T>');
      }
    }
  }

  void notThrowException() {
    try {
      target!.call();
    } catch (e) {
      throw ShouldlyTestFailure('Should not throw any axception');
    }
  }

  @override
  FunctionCap copy(Function? target,
      {bool isReversed = false, String? targetLabel}) {
    return FunctionCap(
      target,
      isReversed: isReversed,
      targetLabel: targetLabel,
    );
  }
}
