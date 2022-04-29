import 'package:test/test.dart';

void main() {
  const actual = 2;

  test('all', () {
    //

    expect(actual, isTrue);
    expect(actual, contains(2));
    expect(actual, startsWith('1'));
    expect(actual, isEmpty);
    expect(actual, throwsException);
  });

  test('bo0lean', () {
    expect(actual, isTrue);
  });

  test('array contains', () {
    expect(actual, contains(2));
  });

  test('string starts with', () {
    expect(actual, startsWith('1'));
  });

  test('string is empty', () {
    expect(actual, isEmpty);
  });

  test('throws exception', () {
    expect(actual, throwsException);
  });
}
