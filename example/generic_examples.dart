// ignore_for_file: avoid_print

import 'package:shouldly/shouldly.dart';

void main() {
  genericExample();
}

void genericExample() {
  const val = 2.0;

  val.should.beOfType<double>(); //oops, doubles aren't int --> error

  //2.0 == 2.0 && 2.0 != 0--> No error
  val.should.beEqual(2.0).and.not.beEqual(0);

  val.should.beEqual(2);

  print('Done');
}
