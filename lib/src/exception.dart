/// An exception thrown when a test assertion fails.
class ShouldlyTestFailureError extends Error {
  /// Error message
  final String? message;

  /// Initializes a new instance of the `ShouldlyTestFailure` class.
  ShouldlyTestFailureError(this.message);

  @override
  String toString() => message.toString();
}
