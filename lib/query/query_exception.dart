class QueryException implements Exception {
  QueryException([this.message, this.rawException]);
  final String? message;
  final String? rawException;

  String getFullMessage() {
    return "$message\nRawException: ${rawException ?? 'null'}";
  }

  @override
  String toString() {
    if (message == null) return "QueryException";
    if (rawException == null) return message!;
    return getFullMessage();
  }
}
