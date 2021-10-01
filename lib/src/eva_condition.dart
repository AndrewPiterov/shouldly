import 'package:shouldly/src/exception.dart';

///
class EvalCondition<T> {
  ///
  bool Function(T? target) condition;

  ///
  final T? target;

  ///
  final String errorMessage;

  ///
  final String errorMessageForReverse;

  ///
  EvalCondition({
    required this.condition,
    required this.target,
    required this.errorMessage,
    required this.errorMessageForReverse,
  });

  ///
  void eval({bool isReversed = false}) {
    final res = condition(target);
    if (isReversed) {
      if (res) {
        throw ShouldlyTestFailure(errorMessageForReverse);
      }
    } else {
      if (!res) {
        throw ShouldlyTestFailure(errorMessage);
      }
    }
  }
}
