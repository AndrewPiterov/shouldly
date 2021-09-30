import 'package:shouldly/shouldly_bool.dart';

void main() {
  final iamRock = true;

  // Type checking
  iamRock.should.beTypeOf<bool>();

  // Equality checking
  iamRock.should.beTrue();
  iamRock.should.not.beFalse();
  iamRock.should.beEqual(true);
  iamRock.should.not.beEqual(false);
  iamRock.should.beEqual(true);
  iamRock.should.not.beEqual(false);

  print('Done with bools');
}
