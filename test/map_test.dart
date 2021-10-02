import 'package:shouldly/shouldly_map.dart';
import 'package:test/test.dart';

void main() {
  group('Map', () {
    final target = {
      'name': 'John',
      'age': 32,
      'hasChildren': null,
    };

    // TODO:  check
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

    test('should have items', () {
      target.should.not.haveCount(2).and.not.beEmpty().and.haveCount(3);
    });

    test('empty map should have count 0', () {
      final map = {};
      map.should.haveCount(0).and.beEmpty();
    });

    test('should be type of Map', () {
      target.should.beAssignableTo<Map>();
    });

    test('should be type of Map (with specify genetic types)', () {
      target.should.beAssignableTo<Map<String, Object?>>();
    });

    test('should be equal', () {
      target.should.not
          .beNull()
          .and
          .be({
            'name': 'John',
            'age': 32,
            'hasChildren': null,
          })
          .and
          .containKey('name');
    });

    test('should not be equal', () {
      target.should.not.be({
        'name': 'John',
        'age': 33,
        'hasChildren': null,
      });
    });

    test('should contain key', () {
      target.should.containKey('name');
    });

    test('should not contain key', () {
      target.should.not.containKey('isMarried');
    });

    test('should not contain keys', () {
      target.should.containKeys(['name', 'age']);
    });

    test('should not contain keys', () {
      target.should.not.containKeys(['isMarried', 'age']);
    });

    test('should have value in key', () {
      target.should.hasValueInKey('name');
    });

    test('should not have value in key', () {
      target.should.not.hasValueInKey('hasChildren');
    });

    test('should contain key with exact value', () {
      target.should.containKeyWithValue('name', 'John');
    });

    test('should not contain key with value', () {
      target.should.not.containKeyWithValue('age', 17);
    });

    group('contain', () {
      test('should contain keys with values', () {
        target.shouldAs('John').contain(const [
          MapEntry('name', 'John'),
          MapEntry('age', 32),
        ]);
      });

      test('should not contain keys with values', () {
        target.should.as('customer').not.contain(const [
          MapEntry('firstName', 'John'),
          MapEntry('address', 'NYC'),
        ]);
      });
    });
  });
}
