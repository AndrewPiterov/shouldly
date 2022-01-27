import 'package:shouldly/shouldly.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('String - contain -', () {
    test('should contain', () {
      'Flutter'.should.contain('F');
    });

    test('should contain ignore case', () {
      'Flutter'.should.contain('f', ignoreCase: true);
    });

    test('should not contain in case sensitive', () {
      Should.throwError<ShouldlyTestFailureError>(
        () => 'Flutter'.should.contain('f'),
      );
    });

    test('should not contain', () {
      'Flutter'.should.not.contain('a');
    });

    test('should not contain case sensivity', () {
      'Flutter'.should.not.contain('f');
    });

    test('should not contain ignore case', () {
      final err = Should.throwError<ShouldlyTestFailureError>(
        () => 'Flutter'.should.not.contain('F'),
      );

      err.message.should.contain('to not contain');
    });

    group('failure mesages', () {
      test('contain', () {
        Should.throwException(() => expect('Flutter', 'Awesome'));
      });

      test('should contain', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 'Flutter'.should.contain('Awesome'),
        );
      });
    });
  });
}
