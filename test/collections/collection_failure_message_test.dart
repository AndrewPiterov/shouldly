import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

void main() {
  const items = [1, 2, 3, 4];

  test(
    'true should be `true`',
    () {
      const o = 10;
      final error = Should.throwError(() => items.should.contain(10));
      final x = error as ShouldlyTestFailureError;
      final msg = x.message;
      msg.should.be('Expected collection to contain `${o.runtimeType}`');
    },
    skip: true,
  );
}
