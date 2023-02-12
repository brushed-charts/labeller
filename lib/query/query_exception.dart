class QueryException implements Exception {
  QueryException([this.message, this.rawException]);
  final String? message;
  final String? rawException;

  String getFullMessage() {
    return "$message\nRawException: $rawException";
  }

  @override
  String toString() {
    return message ?? 'QueryException';
  }
}
