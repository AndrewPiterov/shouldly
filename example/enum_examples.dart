// ignore_for_file: avoid_print

import 'package:shouldly/shouldly_enum.dart';

enum seasons {
  spring,
  summer,
  fall,
  winter,
}

enum level {
  low,
  medium,
  high,
}

void main() {
  // should be equal'
  seasons.spring.should.be(seasons.spring);

  // should not be equal
  seasons.spring.should.not.be(seasons.winter);

  // should be type of
  seasons.spring.should.beOfType<seasons>();

  // should not be type of
  seasons.spring.should.not.beOfType<level>();

  // should be assignable to `Enum`
  seasons.spring.should.beAssignableTo<Enum>();

  print('Done with enums');
}
