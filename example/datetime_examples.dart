// ignore_for_file: avoid_print

import 'package:shouldly/shouldly_datetime.dart';

void main() {
  // should be equal'
  DateTime(2021, 9, 9).should.be(DateTime(2021, 9, 9));

  // after
  DateTime(2021, 9, 9).should.beAfter(DateTime(2021, 1, 12));
  DateTime(2021, 9, 9).should.not.beAfter(DateTime(2021, 9, 10));

  // before
  DateTime(2021, 9, 9).should.beBefore(DateTime(2021, 9, 10));
  DateTime(2021, 9, 9).should.not.beBefore(DateTime(2021, 9, 9));

  // close to
  DateTime(2021, 9, 9, 1, 1, 1, 2).should.beCloseTo(
        DateTime(2021, 9, 9, 1, 1, 1, 3),
        delta: const Duration(milliseconds: 1),
      );

  DateTime(2021, 9, 9, 1, 1, 1, 2).should.not.beCloseTo(
        DateTime(2021, 9, 9, 1, 1, 1, 4),
        delta: const Duration(milliseconds: 1),
      );

  print('Done with DateTimes');
}
