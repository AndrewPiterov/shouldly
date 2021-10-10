import 'package:shouldly/shouldly_stream.dart';
import 'package:test/test.dart';

void main() {
  late MyCounter reverseCounter;

  group('reverse_counter -', () {
    //This will run before every test
    setUp(() => reverseCounter = ReverseCounter());

    test('should emit numbers in decreasing order', () {
      reverseCounter.countStream(3).should.emitsInOrder([4, 3, 2, 1, 0]);
    });

    // test('should always emit 0  at the end', () {
    //   expect(
    //     reverseCounter.countStream(3),
    //     emitsInOrder([emitsThrough(0), emitsDone]),
    //   );
    // });

    // test(
    //     'should always emit numbers within the range(upperBound,0) inclusively',
    //     () {
    //   const upperBound = 3;
    //   reverseCounter.countStream(upperBound).listen(
    //         expectAsync1(
    //           (value) => expect(value, inInclusiveRange(0, upperBound)),
    //           count: upperBound + 1,
    //         ),
    //       );
    // });

    // test("shouldn't emit negative numbers", () {
    //   expect(reverseCounter.countStream(3), neverEmits(isNegative));
    // });
  });
}

abstract class MyCounter {
  Stream<int> countStream(int bound);
}

class ForwardCounter extends MyCounter {
  @override
  Stream<int> countStream(int upperBound) async* {
    for (int i = 0; i <= upperBound; i++) {
      yield i;
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}

class ReverseCounter implements MyCounter {
  @override
  Stream<int> countStream(int upperBound) async* {
    for (int i = upperBound; i >= 0; i--) {
      yield i;
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
