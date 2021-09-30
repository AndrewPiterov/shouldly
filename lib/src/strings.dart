import 'package:shouldly/src/cap.dart';
import 'package:shouldly/src/exception.dart';

extension StringExtensions on String? {
  StringCap get should => StringCap(this);
}

class StringCap extends Cap<String, StringCap> {
  StringCap(String? target, {bool isReversed = false, String? targetLabel})
      : super(target, isReversed: isReversed, targetLabel: targetLabel);

  StringCap startWith(String str) {
    if (isReversed) {
      if (target!.startsWith(str)) {
        throw ShouldlyTestFailure(
            '\n$targetLabel string\n    `$target`\nshould not start with\n    `$str`\nbut it does');
      }
    } else {
      if (!target!.startsWith(str)) {
        throw ShouldlyTestFailure(
            '\n$targetLabel string\n    `$target`\nshould end start\n    `$str`\nbut it does not');
      }
    }

    return StringCap(target);
  }

  StringCap endWith(String str) {
    if (isReversed) {
      if (target!.endsWith(str)) {
        throw ShouldlyTestFailure(
            '\n$targetLabel string\n    `$target`\nshould not end with\n    `$str`\nbut it does');
      }
    } else {
      if (!target!.endsWith(str)) {
        throw ShouldlyTestFailure(
            '\n$targetLabel string\n    `$target`\nshould end with\n    `$str`\nbut it does not');
      }
    }

    return StringCap(target);
  }

  StringCap hasLength(int length) {
    if (isReversed) {
      if (target!.length == length) {
        throw ShouldlyTestFailure(
            'String length of \'$target\' is $length chars');
      }
      return StringCap(target, isReversed: isReversed);
    }

    if (target!.length != length) {
      throw ShouldlyTestFailure(
          'String length of \'$target\' is not $length chars');
    }

    return StringCap(target, isReversed: isReversed);
  }

  StringCap get beNullOrEmpty {
    if (isReversed) {
      if (target == null || target == '') {
        throw ShouldlyTestFailure(
            '\n$targetLabel string\n    `$target`\nshould not be null or empty');
      }
      return StringCap(target);
    } else {
      if (target != null && target != '') {
        throw ShouldlyTestFailure(
            '\n$targetLabel string\n    `$target`\nshould be null or empty');
      }
    }

    return StringCap(target, isReversed: isReversed);
  }

  StringCap get beBlank {
    final trimmed = target!.trim();
    if (isReversed) {
      if (trimmed.isEmpty) {
        throw ShouldlyTestFailure(
            '\n$targetLabel string\n    `$target`\nshould not be blank');
      }
      return StringCap(target);
    } else {
      if (trimmed.isNotEmpty) {
        throw ShouldlyTestFailure(
            '\n$targetLabel string\n    `$target`\nshould be blank');
      }
    }

    return StringCap(target, isReversed: isReversed);
  }

  StringCap match(String exp) {
    final regExp = RegExp(exp);
    if (isReversed) {
      if (regExp.hasMatch(target!)) {
        throw ShouldlyTestFailure(
            '\n$targetLabel string\n  `$target`\nshould not match\n    `$exp`\nbut does');
      }
    } else {
      if (!regExp.hasMatch(target!)) {
        throw ShouldlyTestFailure(
            '\n$targetLabel string\n  `$target`\nshould match\n    `$exp`\nbut it does not');
      }
    }

    return StringCap(target, isReversed: isReversed);
  }

  @override
  StringCap copy(String? target,
      {bool isReversed = false, String? targetLabel}) {
    return StringCap(
      target,
      isReversed: isReversed,
      targetLabel: targetLabel,
    );
  }
}
