import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart' as t;

///
extension StreamExtension<T> on Stream<T>? {
  /// Returns an `StreamsAssertions` object that can be used to assert the
  /// current `Stream` />.
  StreamsAssertions get should => StreamsAssertions(this);
}

///
class StreamsAssertions<T>
    extends BaseAssertions<Stream<T>, StreamsAssertions<T>> {
  ///
  StreamsAssertions(
    Stream<T>? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) : super(subject, isReversed: isReversed, subjectLabel: subjectLabel);

  ///
  StreamsAssertions emitsInOrder<T>(Iterable<T> expected) {
    if (isReversed) {
      // t.expect(subject, t.no(expected));
    } else {
      t.expect(subject, t.emitsInOrder(expected));
    }

    return copy(subject, subjectLabel: subjectLabel);
  }

  @override
  StreamsAssertions<T> copy(
    Stream<T>? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) {
    return StreamsAssertions<T>(
      subject,
      isReversed: isReversed,
      subjectLabel: subjectLabel,
    );
  }
}
