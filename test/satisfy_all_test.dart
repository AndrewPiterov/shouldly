import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';

void main() {
  const person = Person(
    id: 1,
    name: 'Andrew',
    age: 18,
  );

  test('ShouldSatisfyAllConditions', () {
    Should.shouldSatisfyAllConditions([
      () => person.id.should.beGreaterThan(0),
      () => person.name.should.startWith('A'),
      () => person.age.should.not.beNull(),
    ]);
  });

  test('ShouldSatisfyAllConditions throw errors', () {
    final err = Should.throwError<ShouldlyTestFailureError>(
      () => Should.shouldSatisfyAllConditions([
        () => person.id.should.beGreaterThan(10),
        () => person.name.should.startWith('a'),
        () => person.age.should.as('age').beNull(),
      ]),
    );

    // print(err.message);
  });
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
