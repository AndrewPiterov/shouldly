import 'package:shouldly/src/cap.dart';

extension StringExtensions on String {
  Cap<String> get should => Cap<String>(this);
}

extension StringCapExtensions on Cap<String> {
  Cap<String> startWith(String str) {
    if (isReversed) {
      if (target.startsWith(str)) {
        throw Exception(
            '\ntarget string\n    `$target`\nshould not start with\n    `$str`\nbut it does');
      }
    } else {
      if (!target.startsWith(str)) {
        throw Exception(
            '\ntarget string\n    `$target`\nshould end start\n    `$str`\nbut it does not');
      }
    }

    return Cap(target);
  }

  Cap<String> endWith(String str) {
    if (isReversed) {
      if (target.endsWith(str)) {
        throw Exception(
            '\ntarget string\n    `$target`\nshould not end with\n    `$str`\nbut it does');
      }
    } else {
      if (!target.endsWith(str)) {
        throw Exception(
            '\ntarget string\n    `$target`\nshould end with\n    `$str`\nbut it does not');
      }
    }

    return Cap(target);
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

  Cap<String> get beNullOrEmpty {
    if (isReversed) {
      if (target == null || target == '') {
        throw Exception(
            'target string\n    `$target`\nshould not be null or empty');
      }
      return Cap(target);
    } else {
      if (target != null && target != '') {
        throw Exception(
            'target string\n    `$target`\nshould be null or empty');
      }
    }

    return Cap(target, isReversed: isReversed);
  }

  Cap<String> get beBlank {
    final trimmed = target.trim();
    if (isReversed) {
      if (trimmed.isEmpty) {
        throw Exception('\ntarget string\n    `$target`\nshould not be blank');
      }
      return Cap(target);
    } else {
      if (trimmed.isNotEmpty) {
        throw Exception('\ntarget string\n    `$target`\nshould be blank');
      }
    }

    return Cap(target, isReversed: isReversed);
  }

  Cap<String> match(String exp) {
    final regExp = RegExp(exp);
    if (isReversed) {
      if (regExp.hasMatch(target)) {
        throw Exception(
            '\ntarget string\n  `$target`\nshould not match\n    `$exp`\nbut does');
      }
    } else {
      if (!regExp.hasMatch(target)) {
        throw Exception(
            '\ntarget string\n  `$target`\nshould match\n    `$exp`\nbut it does not');
      }
    }

    return Cap(target, isReversed: isReversed);
  }
}
