/// An exception thrown when a test assertion fails.
class ShouldlyTestFailure {
  final String? message;

  ShouldlyTestFailure(this.message);

  @override
  String toString() => message.toString();
}
