import 'package:shouldly/src/base_assertions.dart';
import 'package:shouldly/src/exception.dart';

/// Contains Functions's extension methods for custom assertions in unit tests.
extension FunctionExtensions on Function {
  /// Returns an `FunctionAssertions` object that can be used to assert the
  /// current `Function` />.
  FunctionAssertions get should => FunctionAssertions(this);
}

///
class FunctionAssertions extends BaseAssertions<Function, FunctionAssertions> {
  ///
  FunctionAssertions(
    Function? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) : super(subject, isReversed: isReversed, subjectLabel: subjectLabel);

  /// Expects the function to throw any exception.
  void throwException() {
    try {
      subject!.call();
      throw FunctionExecutionException(
        'The function has not thowed any exception',
      );
    } catch (e) {
      if (e is FunctionExecutionException) {
        rethrow;
      }
    }
  }

  /// Expects the function to throw specified exception.
  void throwExact<T extends Exception>() {
    try {
      subject!.call();
      throw FunctionExecutionException(
        'The function has not thowed any exception',
      );
    } catch (e) {
      if (e is FunctionExecutionException) {
        rethrow;
      }

      if (e is! T) {
        throw ShouldlyTestFailure(
          'Should throw the axception of exact type <$T>',
        );
      }
    }
  }

  /// Expects the function to not throw any exception.
  void notThrowException() {
    try {
      subject!.call();
    } catch (e) {
      throw ShouldlyTestFailure('Should not throw any axception');
    }
  }

  @override
  FunctionAssertions copy(
    Function? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) {
    return FunctionAssertions(
      subject,
      isReversed: isReversed,
      subjectLabel: subjectLabel,
    );
  }
}

///
class FunctionExecutionException implements Exception {
  ///
  final String cause;

  ///
  FunctionExecutionException(this.cause);
}
