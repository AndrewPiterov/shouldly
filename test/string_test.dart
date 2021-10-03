import 'package:shouldly/shouldly.dart';
import 'package:shouldly/shouldly_string.dart';
import 'package:test/test.dart';

void main() {
  group('String -', () {
    test('comparison', () {
      const str = 'Flutter';
      str.toLowerCase().should.be('flutter');
    });

    test('comparison with not equal', () {
      const str = 'Flutter';
      str.should.be('Flutter').and.not.be('flutter');
    });

    test('length should be excact length', () {
      const str = 'Flutter';
      str.should.haveLength(str.length);
    });

    test('length should not be wrong length', () {
      const str = 'Flutter';
      str.should.not.haveLength(str.length + 1);
    });

    test('should start with subsctring', () {
      const str = 'Flutter';
      str.should.startWith('F');
    });

    test('should end with subsctring', () {
      const str = 'Flutter';
      str.should.endWith('r');
    });

    test('should not start with substring', () {
      const str = 'Flutter';
      str.should.not.startWith('f');
    });

    test('should starts with and has length', () {
      const str = 'Flutter';
      str.should.startWith('F').and.haveLength(str.length);
    });

    test('should not start with and not have wrong length', () {
      const str = 'Flutter';
      str.should.not.startWith('k').and.not.haveLength(str.length + 1);
    });

    test('should match to Regular Expression', () {
      const target = 'Bart Simpson';
      target.should.match('Bart .*');
    });

    test('should not match to Regular Expression', () {
      const target = 'Homer Simpson';
      target.should.not.match('Bart .*');
    });

    group('null -', () {
      test('nullable string with value should not be null', () {
        const nullableString = 'Some string';
        nullableString.should.not.beNull().and.not.beBlank();
      });

      test('nullable string without value should be null', () {
        const String? nullableString = null;
        nullableString.should.beNull();
      });
    });

    group('blank -', () {
      test('empty string should be blank', () {
        ''.should.beBlank().and.beNullOrEmpty();
      });

      test('only white spaces', () {
        '  '.should.beBlank().and.not.beNullOrEmpty();
      });

      test('string should not be blank', () {
        'some string'.should.not.beBlank();
        'x'.should.not.beNull().and.not.beBlank();
      });

      test('string should be null or whitespace', () {
        '   '.should.beNullOrWhiteSpace();
      });

      test('string should not be null or whitespace', () {
        '  x '.should.not.beNullOrWhiteSpace();
      });
    });

    group('throw error -', () {
      test('start with', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 'string'.should.startWith('a'),
        );
      });

      test('not start with', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 'string'.should.not.startWith('s'),
        );
      });

      test('end with', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 'string'.should.endWith('a'),
        );
      });

      test('not end with', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 'string'.should.not.endWith('g'),
        );
      });

      test('have length', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 'string'.should.haveLength(100),
        );
      });

      test('not have length', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 'string'.should.not.haveLength(6),
        );
      });

      test('be null or empty', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 'string'.should.beNullOrEmpty(),
        );
      });

      test('not be null or empty', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => ''.should.not.beNullOrEmpty(),
        );
      });

      test('be blank', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 'string'.should.beBlank(),
        );
      });

      test('not be blank', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => '   '.should.not.beBlank(),
        );
      });

      test('match', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => 'string'.should.match('\\d+'),
        );
      });

      test('match', () {
        Should.throwError<ShouldlyTestFailureError>(
          () => '1234567890'.should.not.match('\\d+'),
        );
      });
    });
  });
}
