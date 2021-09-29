import 'package:shouldly/src/map.dart';
import 'package:test/test.dart';

void main() {
  group('Map', () {
    final target = {
      'name': 'John',
      'age': 32,
      "hasChildren": null,
    };

    test('should contain key', () {
      target.should.containKey('name');
    });

    test('should not contain key', () {
      target.should.not.containKey('isMarried');
    });

    test('should have value in key', () {
      target.should.hasValueInKey('name');
    });

    test('should not have value in key', () {
      target.should.not.hasValueInKey('hasChildren');
    });

    test('should contain key with exact value', () {
      target.should.containKeyWithValue('name', "John");
    });

    test('should not contain key with value', () {
      target.should.not.containKeyWithValue('age', 17);
    });
  });
}
