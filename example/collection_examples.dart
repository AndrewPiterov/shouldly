import 'package:shouldly/shouldly_collection.dart';

void main() {
  final attendies = ['Andrew', 'Bobby', 'Larry'];

  // Type checking
  attendies.should.beTypeOf<Iterable>();
  attendies.should.beTypeOf<Iterable<String>>();

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
