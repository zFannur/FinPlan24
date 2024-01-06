
class ErrorEntity {

  ErrorEntity({
    required this.message,
    this.errorMessage,
    this.error,
    this.stackTrace,
  });
  final String message;
  final String? errorMessage;
  final dynamic error;
  final StackTrace? stackTrace;
}
