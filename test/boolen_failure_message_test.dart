import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

void main() {
  const label = 'res';

  test('true should be `true`', () {
    // final error = false
    //     .should
    //     .as(label)
    //     .beTrue
    //     .should
    //     .throwError<ShouldlyTestFailureError>();
    final error = Should.throwError(false.should.as(label).beTrue);
    final x = error as ShouldlyTestFailureError;
    final msg = x.message;
    msg.should
        .be('Expected `$label` to be\n    `true`\nbut found\n    `false`');
  });

  // test('false should be `false`', () {
  //   final error = Should.throwError(true.should.as(label).beFalse);
  //   final x = error as ShouldlyTestFailureError;
  //   final msg = x.message;
  //   msg.should.be('Expected `$label` to be False, but found True.');
  // });

  // test('true should not be `true`', () {
  //   final error = Should.throwError(true.should.as(label).not.beTrue);
  //   final x = error as ShouldlyTestFailureError;
  //   final msg = x.message;
  //   msg.should.be('Expected `$label` to not be True, but found True.');
  // });

  // test('false should not be `false`', () {
  //   final error = Should.throwError(false.should.as(label).not.beFalse);
  //   final x = error as ShouldlyTestFailureError;
  //   final msg = x.message;
  //   msg.should.be('Expected `$label` to not be False, but found False.');
  // });
}
