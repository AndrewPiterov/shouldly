import 'package:shouldly/shouldly_collection.dart';

void main() {
  final attendies = ['Andrew', 'Bobby', 'Larry'];

  // Type checking
  attendies.should.beOfType<List<String>>();
  attendies.should.beAssignableTo<Iterable<String>>();

  // Equality
  attendies.should.beEqual(['Andrew', 'Bobby', 'Larry']);
  attendies.should.beEqual(['Andrew', 'Bobby', 'Larry']);

  // Contains
  attendies.should.contain('Andrew');
  attendies.should.not.contain('Andrei');

  attendies.should.containAll(['Andrew', 'Bobby']);
  attendies.should.not.containAll(['Andrei', 'Bobby']);

  print('Done with collection');
}
