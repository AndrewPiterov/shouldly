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
  });
}
