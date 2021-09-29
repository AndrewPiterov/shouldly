import 'package:shouldly/src/cap.dart';

extension StringExtensions on String {
  Cap<String> get should => Cap<String>(this);
}

extension StringCapExtensions on Cap<String> {
  Cap<String> startWith(String str) {
    if (isReversed) {
      if (target.startsWith(str)) {
        throw Exception('String \'$target\' starts with \'$str\'');
      }
      return Cap(target, isReversed: isReversed);
    }

    if (!target.startsWith(str)) {
      throw Exception('String \'$target\' does not start with \'$str\'');
    }

    return Cap(target, isReversed: isReversed);
  }

  Cap<String> hasLength(int length) {
    if (isReversed) {
      if (target.length == length) {
        throw Exception('String length of \'$target\' is $length chars');
      }
      return Cap(target, isReversed: isReversed);
    }

    if (target.length != length) {
      throw Exception('String length of \'$target\' is not $length chars');
    }

    return Cap(target, isReversed: isReversed);
  }

  Cap<String> match(String exp) {
    final regExp = RegExp(exp);
    if (isReversed) {
      if (regExp.hasMatch(target)) {
        throw Exception(
            'target\n  should not match\n$exp\n  but was\n"$target"');
      }
      return Cap(target, isReversed: isReversed);
    }
    if (!regExp.hasMatch(target)) {
      throw Exception('target\n  should match\n$exp\n  but was\n"$target"');
    }

    return Cap(target, isReversed: isReversed);
  }
}
