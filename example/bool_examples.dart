import 'package:shouldly/shouldly_bool.dart';

void main() {
  const iamRock = true;

  // Type checking
  iamRock.should.beOfType<bool>();

  // Equality checking
  iamRock.should.beTrue();
  iamRock.should.not.beFalse();
  iamRock.should.beEqual(true);
  iamRock.should.not.beEqual(false);
  iamRock.should.beEqual(true);
  iamRock.should.not.beEqual(false);

  // ignore: avoid_print
  print('Done with bools');
}
