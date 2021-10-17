import 'package:shouldly/shouldly.dart';
import 'package:shouldly/shouldly_map.dart';
import 'package:test/test.dart';

void main() {
  group('Map -', () {
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

    group('throw error -', () {
      test('compare different maps', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => {}.should.be({'name': 'Anddrew'}),
        );
      });
      test('compare the same map', () {
        Should.throwError<ShouldlyTestFailureError>(() => {}.should.not.be({}));
      });

      group('contains key -', () {
        test('should contain key', () {
          Should.throwError<ShouldlyTestFailureError>(
            () => {}.should.containKey('myKey'),
          );
        });

        test('should not contain key', () {
          Should.throwError<ShouldlyTestFailureError>(
            () => {'myKey': 1}.should.not.containKey('myKey'),
          );
        });
      });

      group('have value in key -', () {
        test('should have value in key', () {
          Should.throwError<ShouldlyTestFailureError>(
            () => {'myKey': null}.should.haveValueInKey('myKey'),
          );
        });

        test('should not have value in key', () {
          Should.throwError<ShouldlyTestFailureError>(
            () => {'myKey': 1}.should.not.haveValueInKey('myKey'),
          );
        });

        test('should not have value in key because non existing key', () {
          Should.throwError<ShouldlyTestFailureError>(
            () => {'myKey': 1}.should.haveValueInKey('myKey2'),
          );
        });
      });

      group('have key with value -', () {
        test('should have key with value', () {
          Should.throwError<ShouldlyTestFailureError>(
            () => {'myKey': 1}.should.containKeyWithValue('myKey', 2),
          );
        });

        test('should not have key with value', () {
          Should.throwError<ShouldlyTestFailureError>(
            () => {'myKey': 1}.should.not.containKeyWithValue('myKey', 1),
          );
        });

        test('should not have key with value because non existing key', () {
          Should.throwError<ShouldlyTestFailureError>(
            () => {'myKey': 1}.should.containKeyWithValue('myKey2', 1),
          );
        });
      });

      group('contain -', () {
        test('should contain key:value', () {
          Should.throwError<ShouldlyTestFailureError>(
            () => {'myKey': 1}.should.contain(const [MapEntry('myKey', 2)]),
          );
        });

        test('should not contain key:value', () {
          Should.throwError<ShouldlyTestFailureError>(
            () => {'myKey': 1}.should.not.contain(const [MapEntry('myKey', 1)]),
          );
        });

        test('should contain key:value - non existing key', () {
          Should.throwError<ShouldlyTestFailureError>(
            () => {'myKey': 1}.should.contain(const [MapEntry('myKey2', 1)]),
          );
        });

        // TODO: test('should not contain key:value - wrong value', () {
        //   Should.throwError<ShouldlyTestFailureError>(
        //     () =>
        //         {'myKey': 1}.should.not.contain(const [MapEntry('myKey2', 1)]),
        //   );
        // });
      });
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

    test('should contain keys', () {
      target.should.containKeys(['name', 'age']);
    });

    test('should not contain keys', () {
      target.should.not.containKeys(['isMarried', 'age']);
    });

    test('should have value in key', () {
      target.should.haveValueInKey('name');
    });

    test('should not have value in key', () {
      target.should.not.haveValueInKey('hasChildren');
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

    group('One of item in an Array', () {
      test('array contain the Map', () {
        final city = {'city': 'Moscow'};
        city.should.beOneOf([
          {'city': 'Moscow'},
          {'city': 'Cairo'}
        ]);
      });

      test('array does not contain the Map', () {
        final city = {'city': 'Moscow'};
        city.should.not.beOneOf([
          {'city': 'New York'},
          {'city': 'Cairo'}
        ]);
      });
    });
  });
}
