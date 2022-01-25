// ignore_for_file: avoid_print

import 'package:shouldly/shouldly.dart';

void main() {
  // Type checking
  someAction.should.beAssignableTo<Function>();
  someFunction.should.beOfType<SumOperation>();
  someFunction.should.not.beOfType<PowerOperation>();

  // Exceptions
  Should.throwException(() => throwException());
  // ignore: deprecated_member_use
  Should.throwException<IntegerDivisionByZeroException>(
    () => throwException(),
  ); // FormatException
  Should.notThrowException(() => someAction());

  print('Done with functions');
}

void someAction() {}

typedef SumOperation = int Function(int a, int b);

typedef PowerOperation = int Function(int num);

int someFunction(int a, int b) {
  return a + b;
}

void throwException() {
  // ignore: deprecated_member_use
  throw const IntegerDivisionByZeroException();
}
