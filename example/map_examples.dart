import 'package:shouldly/shouldly_map.dart';

void main() {
  final product = {
    'id': 1,
    'name': 'Product #1',
  };

  // Type checking
  product.should.beTypeOf<Map>();

  // Equality
  product.should.beEqual({
    'id': 1,
    'name': 'Product #1',
  });

  // Map has a key
  product.should.containKey('name');

  // Map should not contain a key
  product.should.not.containKey('non_existing_key');

  print('Done');
}
