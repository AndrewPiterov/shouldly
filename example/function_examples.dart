import 'package:shouldly/shouldly_function.dart';

void main() {
  // Type checking
  someAction.should.beTypeOf<Function>();
  someFunction.should.beTypeOf<SumOperation>();
  someFunction.should.not.beTypeOf<PowerOperation>();

  // Exceptions
  throwException.should.throwException();
  throwException.should.throwExact<IntegerDivisionByZeroException>();
  someAction.should.notThrowException();

  print('Done with functions');
}

void someAction() {}

typedef SumOperation = int Function(int a, int b);

typedef PowerOperation = int Function(int num);

int someFunction(int a, int b) {
  return a + b;
}

void throwException() {
  throw IntegerDivisionByZeroException();
}
