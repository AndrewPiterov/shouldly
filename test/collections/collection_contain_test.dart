import 'package:given_when_then_unit_test/res/given.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';

const _shouldContain = '''
Expected myNumbers
    should contain
4
    but was actually
[1, 2, 3, 5.0]''';

const _shouldNotContain = '''
Expected myNumbers
    should not contain
5
    but was actually
[1, 2, 3, 5.0]''';

void main() {
  given('Collection', () {
    const myNumbers = [1, 2, 3, 5.0];
    group('- contain -', () {
      test('should contain 5', () {
        myNumbers.should.contain(5.0);
        myNumbers.should.contain(5);
      });

      test('should not contain 4', () {
        myNumbers.should.not.contain(4);
      });

      group('fail message -', () {
        test('should contain template', () {
          //
          final err = Should.throwError<ShouldlyTestFailureError>(
            () => myNumbers.should.as('myNumbers').contain(4),
          );
          err.message.should.be(_shouldContain);
        });

        test('should not contain template', () {
          //
          final err = Should.throwError<ShouldlyTestFailureError>(
            () => myNumbers.should.as('myNumbers').not.contain(5),
          );
          err.message.should.be(_shouldNotContain);
        });
      });
    });
  });
}
