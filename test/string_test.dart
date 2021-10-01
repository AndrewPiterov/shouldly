import 'package:shouldly/src/strings.dart';
import 'package:test/test.dart';

void main() {
  group('String', () {
    test('comparison', () {
      const str = 'Flutter';
      str.toLowerCase().should.beEqual('flutter');
    });

    test('comparison with not equal', () {
      const str = 'Flutter';
      str.should.beEqual('Flutter').and.not.beEqual('flutter');
    });

    test('length should be excact length', () {
      const str = 'Flutter';
      str.should.hasLength(str.length);
    });

    test('length should not be wrong length', () {
      const str = 'Flutter';
      str.should.not.hasLength(str.length + 1);
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
      str.should.startWith('F').and.hasLength(str.length);
    });

    test('should not start with and not have wrong length', () {
      const str = 'Flutter';
      str.should.not.startWith('k').and.not.hasLength(str.length + 1);
    });

    test('should match to Regular Expression', () {
      const target = 'Bart Simpson';
      target.should.match('Bart .*');
    });

    test('should not match to Regular Expression', () {
      const target = 'Homer Simpson';
      target.should.not.match('Bart .*');
    });

    test('nullable string should be null', () {
      const String? nullableString = null;
      nullableString.should.beNull;
    });

    test('nullable string should not be null', () {
      const nullableString = 'Some string';
      nullableString.should.not.beNull.and.not.beBlank;
    });

    test('xxx', () {
      'x'.should.beEqual('x').and.not.beBlank;
      'x'.should.not.beNull.and.not.beBlank;
    });
  });
}
