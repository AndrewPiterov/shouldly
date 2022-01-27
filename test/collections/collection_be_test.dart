import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

void main() {
  group('collection - be -', () {
    group('double and int equality', () {
      const actual = [1, 2, 3];
      const expected = [1, 2, 3.0];
      test('equal - non shouldly', () {
        expect(actual, expected);
      });

      test('equal', () {
        actual.should.be(expected);
      });
    });

    test('compare non empty non equal lists', () {
      [1, 2, 3].should.not.be([1, 2, 4]);
    });

    group('2 demension array', () {
      const arr = [
        [0.5, 0.75],
        [0, 0.25],
        [0.25, 0.5],
        [0.75, 1]
      ];

      const expected = [
        [0.5, 0.75],
        [0.0, 0.25],
        [0.25, 0.5],
        [0.75, 1.0]
      ];

      test('non shouldly', () {
        expect(arr, expected);
      });

      test('shouldly', () {
        arr.should.be(expected);
      });
    });

    group('failure message', () {
      test('should be', () {
        final error = Should.throwError<ShouldlyTestFailureError>(
          () => [1.0, 2, 3, 4, 5].should.as('my numbers').be([1, 2.0]),
        );
        error.message.should.contain('difference');
      });

      test('should be', () {
        final error = Should.throwError<ShouldlyTestFailureError>(
          () => [1, 2, 3].should.as('my numbers').be([1, 2, 3, 4]),
        );
        error.message.should.contain('difference');
      });
    });
  });
}
