import 'package:shouldly/src/map.dart';
import 'package:test/test.dart';

void main() {
  group('Map', () {
    final target = {
      'name': 'John',
      'age': 32,
      "hasChildren": null,
    };

    // TODO: hot to cjeck
    /*
Target _InternalLinkedHashMap<String, Object?>
    _InternalLinkedHashMap<String, Object?>
should be an instantiation of Type
    `LinkedHashMap<String, Object>`
but does not
    */
    // test('should be instantiation of type `Map<String, Object>`', () {
    //   target.should.beOfType<LinkedHashMap<String, Object>>();
    // });

    test('should be type of Map', () {
      target.should.beAssignableTo<Map>();
    });

    test('should be type of Map (with specify genetic types)', () {
      target.should.beAssignableTo<Map<String, Object?>>();
    });

    test('should be equal', () {
      target.should.not.beNull.and
          .beEqual({
            'name': 'John',
            'age': 32,
            "hasChildren": null,
          })
          .and
          .containKey('name');
    });

    test('should not be equal', () {
      target.should.not.beEqual({
        'name': 'John',
        'age': 33,
        "hasChildren": null,
      });
    });

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
