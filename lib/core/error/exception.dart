class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class NotFoundException implements Exception {}

class CachedException implements Exception {}
