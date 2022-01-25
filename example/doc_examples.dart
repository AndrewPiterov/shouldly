// ignore_for_file: avoid_print

import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';

void main() {
  // test('equality', () {
  //   // 18.should.as('my age').be(17);
  // });

  // test('booleans False', () {
  //   // expect(true, isFalse);
  //   false.should.as('marriage').not.beFalse();
  // });

  test('booleans True', () {
    // expect(true, isFalse);
    true.should.as('marriage').not.beTrue();
  });

  // test('null', () {
  //   // int? c;
  //   // Object();
  //   // expect(c, isNull);
  //   // c.should.not.beNull();
  // });

  // test('contains', () {
  //   final weapons = ['sword', 'arrows', 'axe'];
  //   // weapons.should.as('weapon list').contain('bow');

  //   // test('description', () {
  //   //   //
  //   //   expect(weapons, contains('bow'));
  //   // });
  // });

  // test('description', () {
  //   //
  //   // expect('weapons', startsWith('q'));
  //   'weapons'.should.not.startWith('w');
  // });
}
