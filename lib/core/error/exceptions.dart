class DatabaseException implements Exception {
  const DatabaseException(this.message);

  final String message;
}

class CacheException implements Exception {}
