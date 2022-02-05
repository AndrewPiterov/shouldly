import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:shouldly/shouldly.dart';

const _errorMessage = '''
Expected `int`
    should be
100.0
    but was
10''';

const _errorMessageNot = '''
Expected `int`
    should not be
10.0
    but was
10''';

void main() {
  given('Numebr', () {
    const number = 10;
    then('should be 10', () {
      number.should.be(10);
    });

    when('compare with wrong number', () {
      late ShouldlyTestFailureError error;

      before(() {
        error = Should.throwError<ShouldlyTestFailureError>(
          () => number.should.be(100.0),
        );
      });

      then(
        'should throw error',
        () {
          error.should.not.beNull();
        },
        and: {
          'message should be exact string': () =>
              error.message.should.be(_errorMessage),
        },
      );
    });

    when('compare with wrong number', () {
      late ShouldlyTestFailureError error;

      before(() {
        error = Should.throwError<ShouldlyTestFailureError>(
          () => number.should.not.be(10.0),
        );
      });

      then(
        'should throw error',
        () {
          error.should.not.beNull();
        },
        and: {
          'message should be exact string': () =>
              error.message.should.be(_errorMessageNot),
        },
      );
    });

    then('should not be 1', () {
      number.should.not.be(1);
    });
  });
}
