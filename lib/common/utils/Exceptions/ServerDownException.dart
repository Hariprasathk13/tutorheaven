class ServerDownException implements Exception {
  @override
  String toString() {
    return "Service not available at the moment";
  }
}
