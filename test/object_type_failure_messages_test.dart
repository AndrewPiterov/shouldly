import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

void main() {
  const nonNullInt = 2;
  const nonNullObject2 = Object();
  const int? nullObject = null;

  test(
    'should be not null (int)',
    () {
      final error = Should.throwError(nonNullInt.should.beNull);
      final x = error as ShouldlyTestFailureError;
      final msg = x.message;
      msg.should.be(
        'Expected `int` to be <null>, but found `int` (Hashcode=${nonNullInt.hashCode}).',
      );
    },
    skip: true,
  );

  test(
    'should be not null (object)',
    () {
      final error = Should.throwError(nonNullObject2.should.beNull);
      final x = error as ShouldlyTestFailureError;
      final msg = x.message;
      msg.should.be(
        'Expected `Object` to be <null>, but found `Object` (Hashcode=${nonNullObject2.hashCode}).',
      );
    },
    skip: true,
  );

  test(
    'should be null',
    () {
      final error = Should.throwError(nullObject.should.not.beNull);
      final x = error as ShouldlyTestFailureError;
      final msg = x.message;
      msg.should.be('Expected `Null` not to be <null>.');
    },
    skip: true,
  );
}
