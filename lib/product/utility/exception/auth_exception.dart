class AuthException implements Exception {
  final String message;

  AuthException({required this.message});

  @override
  String toString() {
    return "AuthException: $message";
  }
}
