// ignore_for_file: avoid_print

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
  void throwException<T extends Exception>() {
    if (isReversed) {
      try {
        subject!.call();
      } catch (e) {
        final message =
            '$subjectLabel function should not throw exact exception of `$T`';
        print(message);
        throw ShouldlyTestFailureError(message);
      }
    } else {
      try {
        subject!.call();
        throw ShouldlyTestFailureError(
          '\nsubject function does not throw exception',
        );
      } catch (e) {
        if (e is ShouldlyTestFailureError) {
          throw ShouldlyTestFailureError(
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
  }

  /// Expects the function to throw specified exception.
  T? throwError<T extends Error>() {
    if (isReversed) {
      try {
        subject!.call();
        return null;
      } catch (e) {
        final message =
            '$subjectLabel function should not throw exact exception of `$T`';
        print(message);
        throw ShouldlyTestFailureError(message);
      }
    } else {
      try {
        subject!.call();
        throw ShouldlyTestFailureError(
          '\nsubject function does not throw exception',
        );
      } catch (e) {
        if (e is ShouldlyTestFailureError) {
          throw ShouldlyTestFailureError(
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
