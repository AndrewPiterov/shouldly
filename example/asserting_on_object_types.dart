import 'package:shouldly/shouldly.dart';

void main() {
  final enemyFactory = EnemyFactory();

  const enemyName = 'Bossy';
  final enemy = enemyFactory.create(isBoss: true, name: enemyName);

  // exact type
  enemy.should.beOfType<BossEnemy>();
  enemy.should.not.beOfType<Enemy>();

  // assignable to base class
  enemy.should.beAssignableTo<Enemy>();

  // capture the type
  final boss = enemy.should.beOfType<BossEnemy>()!;
  boss.name.should.be(enemyName);
  boss.superPower.should.be(42);

  // ignore: avoid_print
  print('Done with enemies');
}

abstract class Enemy {
  final String name;

  Enemy(this.name);
}

class NormalEnemy extends Enemy {
  NormalEnemy(String name) : super(name);

  int get power => 10;
}

class BossEnemy extends Enemy {
  BossEnemy(String name) : super(name);

  int get superPower => 42;
}

class EnemyFactory {
  Enemy create({required bool isBoss, required String name}) {
    return isBoss ? BossEnemy(name) : NormalEnemy(name);
  }
}

extension EnemyExtension on Enemy? {
  EnemyAssertions get should => EnemyAssertions(this);
}

class EnemyAssertions extends BaseAssertions<Enemy, EnemyAssertions> {
  EnemyAssertions(Enemy? target, {bool isReversed = false, String? targetLabel})
      : super(
          target,
          isReversed: isReversed,
          subjectLabel: targetLabel,
        );

  @override
  EnemyAssertions copy(
    Enemy? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) {
    return EnemyAssertions(
      subject,
      isReversed: isReversed,
      targetLabel: subjectLabel,
    );
  }
}
