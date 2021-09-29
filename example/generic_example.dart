import 'package:shouldly/shouldly.dart';

void main() {
  genericExample();
}

void genericExample() {
  const val = 2.0;

  val.should.beTypeOf<double>(); //oops, doubles aren't int --> error

  // There is three options for type checking:
  // val.should.be<int> is equivalent to: assert(dou is int).
  // val.should.beSubclass (dou is an instance of a subclass of given type)
  // or dou.should.instantiate (dou is a direct instance of given type).

  //2.0 == 2.0 && 2.0 != 0--> No error
  val.should.be(2.0).and.not.equal(0);

  print('evaluated 4 should statements');
}
