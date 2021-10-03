import 'package:shouldly/src/exception.dart';

// ignore: avoid_classes_with_only_static_members
/// Helper class for verifying a condition and/or throwing
/// a test harness specific exception representing an assertion failure.
class Execute {
  /// Gets an object that wraps and executes a conditional
  /// or unconditional assertion.
  static AssertionScope get assertion => AssertionScope.current;
}

///
class AssertionScope {
  /// <summary>Gets the current thread-specific assertion scope.</summary>
  // ignore: prefer_constructors_over_static_methods
  static AssertionScope get current => AssertionScope();
  // {
  //   get => AssertionScope.GetCurrentAssertionScope() ?? new AssertionScope((IAssertionStrategy) new DefaultAssertionStrategy(), (AssertionScope) null);
  //   private set => AssertionScope.SetCurrentAssertionScope(value);
  // }

  // AssertionScope? _parent;
  // Func<string>? expectation;
  ///
  final fallbackIdentifier = 'object';
  var _isFailed = false;

  ///
  // ignore: avoid_positional_boolean_parameters
  AssertionScope forCondition(bool condition) {
    _isFailed = condition;
    return this;
  }

  ///
  void failWith(String message) {
    if (_isFailed) {
      throw ShouldlyTestFailureError('\n$message\n');
    }
  }
}
