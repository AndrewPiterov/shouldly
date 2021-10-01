/// An exception thrown when a test assertion fails.
class ShouldlyTestFailure {
  /// Error message
  final String? message;

  /// Initializes a new instance of the `ShouldlyTestFailure` class.
  ShouldlyTestFailure(this.message);

  @override
  String toString() => message.toString();
}
