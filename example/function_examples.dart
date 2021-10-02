// ignore_for_file: avoid_print

import 'package:shouldly/shouldly_function.dart';

void main() {
  // Type checking
  someAction.should.beAssignableTo<Function>();
  someFunction.should.beOfType<SumOperation>();
  someFunction.should.not.beOfType<PowerOperation>();

  // Exceptions
  throwException.should.throwException();
  throwException.should.throwException<IntegerDivisionByZeroException>();
  someAction.should.not.throwException();

  print('Done with functions');
}

void someAction() {}

typedef SumOperation = int Function(int a, int b);

typedef PowerOperation = int Function(int num);

int someFunction(int a, int b) {
  return a + b;
}

void throwException() {
  throw const IntegerDivisionByZeroException();
}
