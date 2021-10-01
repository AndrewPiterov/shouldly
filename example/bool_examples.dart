import 'package:shouldly/shouldly_bool.dart';

void main() {
  const iamRock = true;

  // Type checking
  iamRock.should.beOfType<bool>();

  // Equality checking
  iamRock.should.beTrue();
  iamRock.should.not.beFalse();
  iamRock.should.be(true);
  iamRock.should.not.be(false);
  iamRock.should.be(true);
  iamRock.should.not.be(false);

  // ignore: avoid_print
  print('Done with bools');
}
