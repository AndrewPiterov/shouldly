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
  EnemyCap get should => EnemyCap(this);
}

class EnemyCap extends BaseAssertions<Enemy, EnemyCap> {
  EnemyCap(Enemy? target, {bool isReversed = false, String? targetLabel})
      : super(
          target,
          isReversed: isReversed,
          targetLabel: targetLabel,
        );

  @override
  EnemyCap copy(Enemy? target, {bool isReversed = false, String? targetLabel}) {
    return EnemyCap(
      target,
      isReversed: isReversed,
      targetLabel: targetLabel,
    );
  }
}
