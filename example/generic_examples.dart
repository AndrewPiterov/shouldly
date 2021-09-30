import 'package:shouldly/shouldly.dart';

void main() {
  genericExample();
}

void genericExample() {
  const val = 2.0;

  val.should.beTypeOf<double>(); //oops, doubles aren't int --> error

  //2.0 == 2.0 && 2.0 != 0--> No error
  val.should.be(2.0).and.not.equal(0);

  val.should.equal(2);

  print('Done');
}
