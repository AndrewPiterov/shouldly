import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

const _shouldBeNullOrEmpty = '''
Expected myString
    should be null or empty
but was
    'some string\'''';

const _shouldNotBeNullOrEmpty = '''
Expected myString
    should not be null or empty
but was
    '\'''';

void main() {
  test('be null or empty', () {
    final err = Should.throwError<ShouldlyTestFailureError>(
      () => 'some string'.should.as('myString').beNullOrEmpty(),
    );
    err.message.should.be(_shouldBeNullOrEmpty);
  });

  test('not be null or empty', () {
    final err = Should.throwError<ShouldlyTestFailureError>(
      () => ''.should.as('myString').not.beNullOrEmpty(),
    );
    err.message.should.be(_shouldNotBeNullOrEmpty);
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

    test('new line should be blank', () {
      '\n\n\n'.should.beBlank();
    });

    test('new line with whitespaces should be blank', () {
      '\n\n\n    \n'.should.beBlank();
    });

    test('should not be blank', () {
      '   \n   .'.should.not.beBlank();
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
}
