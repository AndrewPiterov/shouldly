import 'package:shouldly/src/bool.dart';
import 'package:test/test.dart';

void main() {
  test('true should be `true`', () {
    true.should.be(true);
  });

  test('true should be `true` (second way)', () {
    true.should.beTrue();
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
    nullableTrue.should.beNull;
  });

  test('nullable boolean should not be null', () {
    // ignore: prefer_final_locals
    bool? nullableTrue = true;
    nullableTrue.should.not.beNull;
  });
}
