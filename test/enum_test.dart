import 'package:shouldly/shouldly_enum.dart';
import 'package:test/test.dart';

enum seasons {
  spring,
  summer,
  fall,
  winter,
}

enum level {
  low,
  medium,
  high,
}

void main() {
  group('enum -', () {
    test('should be equal', () {
      seasons.spring.should.be(seasons.spring);
    });

    test('should not be equal', () {
      seasons.spring.should.not.be(seasons.winter);
    });

    test('should be type of', () {
      seasons.spring.should.beOfType<seasons>();
    });

    test('should not be type of', () {
      seasons.spring.should.not.beOfType<level>();
    });

    test('should be assignable to `Enum`', () {
      seasons.spring.should.beAssignableTo<Enum>();
    });

    group('One of item in an Array', () {
      test('array contain the Enum', () {
        seasons.spring.should.beOneOf(
          [seasons.winter, seasons.spring, seasons.summer, seasons.fall],
        );
      });

      test('array does not contain the Enum', () {
        seasons.winter.should.not
            .beOneOf([seasons.spring, seasons.summer, seasons.fall]);
      });
    });
  });
}
