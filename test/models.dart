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

class Person {
  const Person({
    required this.id,
    required this.name,
    this.age,
  });

  final int id;
  final String name;
  final int? age;
}
