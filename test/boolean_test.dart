import 'package:shouldly/shouldly.dart';
import 'package:shouldly/shouldly_bool.dart';
import 'package:shouldly/src/should.dart';
import 'package:test/test.dart';

void main() {
  test('true should be `true`', () {
    true.should.be(true);
  });

  group('throw error -', () {
    test('when `true` should be `false`', () {
      Should.throwError<ShouldlyTestFailureError>(() => true.should.be(false));
    });

    test('when `true` should not be `true`', () {
      Should.throwError<ShouldlyTestFailureError>(
        () => true.should.not.be(true),
      );
    });
  });

  group('true -', () {
    test('true should be `true` (second way)', () {
      true.should.beTrue();
    });
  });

  test('false should be `false`', () {
    false.should.beFalse();
  });

  test('false should be `false` (second way)', () {
    false.should.be(false);
  });

  test('false should not be `true`', () {
    false.should.not.beTrue();
  });

  test('false should not be `true` (second way)', () {
    false.should.not.be(true);
  });

  test('true should not be `false`', () {
    true.should.not.beFalse();
  });

  test('nullable boolean should be null', () {
    const bool? nullableTrue = null;
    nullableTrue.should.beNull();
  });

  test('nullable boolean should not be null', () {
    // ignore: prefer_final_locals
    bool? nullableTrue = true;
    nullableTrue.should.not.beNull();
  });

  group('One of item in an Array', () {
    test('array contain the True', () {
      true.should.beOneOf([false, true]);
    });

    test('array does not contain the True', () {
      true.should.not.beOneOf([false, false, false]);
    });
  });
}
