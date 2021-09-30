import 'package:shouldly/shouldly_bool.dart';

void main() {
  final iamRock = true;

  // Type checking
  iamRock.should.beTypeOf<bool>();

  // Equality checking
  iamRock.should.beTrue();
  iamRock.should.not.beFalse();
  iamRock.should.be(true);
  iamRock.should.not.be(false);
  iamRock.should.equal(true);
  iamRock.should.not.equal(false);

  print('Done with bools');
}
