import 'dart:developer';

import 'package:shouldly/src/datetimes/datetimes.dart';
import 'package:shouldly/src/numbers/numbers.dart';
import 'package:test/test.dart';

void main() {
  group('DateTime', () {
    group('`be equal`', () {
      test('should be equal', () {
        final d1 = DateTime(2021, 1, 1);
        final d2 = DateTime(2021, 1, 1);

        d1.should.be(d2);
      });

      test('should not be equal', () {
        final d1 = DateTime.now();
        final d2 = DateTime.now();

        d1.should.not.be(d2);
      });
    });

    group('`beAfter`', () {
      test('should be after', () {
        final d1 = DateTime(2021, 1, 1, 22, 30, 12, 0, 1);
        final d2 = DateTime(2021, 1, 1, 22, 30, 12, 0, 2);

        d2.should.beAfter(d1);
        d1.should.not.beAfter(d2);
      });

      test('should not be after', () {
        final d1 = DateTime(2021, 1, 1, 22, 30, 12, 0, 1);
        final d2 = DateTime(2021, 1, 1, 22, 30, 12, 0, 1);

        d2.should.not.beAfter(d1);
      });
    });

    group('`beBefore`', () {
      test('should be after', () {
        final d1 = DateTime(2021, 1, 1, 22, 30, 12, 0, 1);
        final d2 = DateTime(2021, 1, 1, 22, 30, 12, 0, 2);

        d1.should.beBefore(d2);
        d2.should.not.beBefore(d1);
      });

      test('should not be after', () {
        final d1 = DateTime(2021, 1, 1, 22, 30, 12, 0, 1);
        final d2 = DateTime(2021, 1, 1, 22, 30, 12, 0, 1);

        d1.should.not.beBefore(d2);
      });
    });

    group('beCloseTo', () {
      test(
        'should be close to',
        () {
          final d1 = DateTime.now();
          final d2 = DateTime.now();

          final delta = d2.difference(d1);
          log('Diff: $delta');
          log('Diff in ms: ${delta.inMilliseconds}');
          log('Diff in microseconds: ${delta.inMicroseconds}');

          d1.should.beCloseTo(d2, delta: const Duration(milliseconds: 1));
          delta.inMicroseconds.should.beGreaterThan(0);
        },
        skip: 'Not deterministic',
      );

      test('microseconds', () {
        final d1 = DateTime(2021, 1, 1, 22, 30, 12, 0, 1);
        final d2 = DateTime(2021, 1, 1, 22, 30, 12, 0, 2);

        d1.should.beCloseTo(d2, delta: const Duration(microseconds: 1));
      });

      test('microseconds (2)', () {
        final d1 = DateTime(2021, 1, 1, 22, 30, 12, 0, 1);
        final d2 = DateTime(2021, 1, 1, 22, 30, 12, 0, 3);

        d1.should.not.beCloseTo(d2, delta: const Duration(microseconds: 1));
      });

      test('seconds', () {
        final d1 = DateTime(2021, 1, 1, 22, 30, 12, 0, 1);
        final d2 = DateTime(2021, 1, 1, 22, 30, 13, 0, 1);

        d1.should.beCloseTo(d2, delta: const Duration(seconds: 1));
      });

      test('seconds (2)', () {
        final d1 = DateTime(2021, 1, 1, 22, 30, 12, 0, 1);
        final d2 = DateTime(2021, 1, 1, 22, 30, 13, 0, 3);

        d1.should.not.beCloseTo(d2, delta: const Duration(seconds: 1));
      });
    });
  });
}
