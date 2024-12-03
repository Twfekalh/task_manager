class ServerException implements Exception {
  final String message;

  ServerException([this.message = 'Server exception occurred.']);
}

class EmptyCacheException implements Exception {
  final String message;

  EmptyCacheException([this.message = 'No data found in cache.']);
}

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = 'No internet connection.']);
}
