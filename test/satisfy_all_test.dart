import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';

import 'models.dart';

void main() {
  const person = Person(
    id: 1,
    name: 'Andrew',
    age: 18,
  );

  test('should satisfy all conditions', () {
    Should.satisfyAllConditions([
      () => person.id.should.beGreaterThan(0),
      () => person.name.should.startWith('A'),
      () => person.age.should.not.beNull(),
    ]);
  });

  test('ShouldSatisfyAllConditions throw errors', () {
    final err = Should.throwError<ShouldlyTestFailureError>(
      () => Should.satisfyAllConditions([
        () => person.id.should.beGreaterThan(10),
        () => person.name.should.startWith('a'),
        () => person.age.should.as('age').beNull(),
      ]),
    );

    // print(err.message);
  });
}
