import 'package:shouldly/shouldly_num.dart';

void main() {
  const myIntNumber = 2021;

  // Type checking
  myIntNumber.should.beTypeOf<num>();
  myIntNumber.should.beTypeOf<int>();

  // or you can concatinate with `and`
  myIntNumber.should
      .beTypeOf<num>()
      .and
      .beTypeOf<int>()
      .and
      .not
      .beTypeOf<double>();

  //
  20.should.beGreaterThan(19);
  20.should.beAbove(19);

  20.should.beLessThan(21).and.beBelow(21);

  20.should.beLessOrEqualThan(20).and.beGreaterOrEqualThan(20);

  20.should.beWithin(10, 30);
  20.should.beWithin(20, 20);
  20.should.not.beWithin(10, 15);
  20.should.not.beWithin(21, 30);
  20.should.beWithin(20, 30);

  20.should.not.beBelow(20).and.not.beAbove(20);
  20.should.not.beAbove(20).and.not.beBelow(20);
  20.should.not.beAbove(21).and.not.beBelow(19);

  print('Done with numbers');
}
