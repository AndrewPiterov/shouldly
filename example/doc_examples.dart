import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

void main() {
  const playerCharacter = PlayerCharacter(
    'Arthur',
    100,
    ['Axe', 'Sword', 'Staff of Wonder'],
  );

/*
Expected: <10>
  Actual: <100>

Expected health
    should be
10
    but was
100
*/
  // test('equality', () {
  //   expect(playerCharacter.health, 10);
  //   playerCharacter.health.should.be(10);
  // });

  /*
    Expected: contains 'Staff of Wonderr'
      Actual: ['Axe', 'Sword', 'Staff of Wonder']

  Expected `weapons`
      should contain 
  Staff of Wonderr
      but does not
  [Axe, Sword, Staff of Wonder]
  */

  // test('array contains', () {
  //   expect(playerCharacter.weapons, contains('Staff of Wonderr'));
  //   playerCharacter.weapons.should.as('weapons').contain('Staff of Wonderr');
  // });

  /*
    Expected: null
      Actual: 'Arthur'

  Expected `nickname`
      should be null or empty
  but was
      `Arthur`
  */

  test('nullability of string', () {
    // expect(playerCharacter.nickname, isNull);
    playerCharacter.nickname.should.as('nickname').beNullOrEmpty();
  });
}

class PlayerCharacter {
  const PlayerCharacter(
    this.nickname,
    this.health,
    this.weapons,
  );

  final String nickname;
  final int health;
  final List<String> weapons;
}
