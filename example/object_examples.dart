// ignore_for_file: avoid_print

import 'package:shouldly/shouldly.dart';

class Hero {
  final String name;

  const Hero(this.name);
}

/// This example for case when you do not have custom assertions for your classes yet
///
/// In this case you can use general `ObjectAssertions`
void main() {
  const hero = Hero('Andrew');
  const heroCopy = hero;
  const hero2 = Hero('Mike');
  const Hero? nullableHero = null;

  hero.should.not.beNull();
  hero2.should.not.beNull();
  nullableHero.should.beNull();

  hero.should.beOfType<Hero>();
  hero.should.beAssignableTo<Hero>();
  hero.should.beAssignableTo<Object>();

  hero.should.be(heroCopy);
  hero.should.not.be(hero2);

  // TODO: hero.should.not.beSameAs(heroCopy);

  print('Done with heroes');
}
