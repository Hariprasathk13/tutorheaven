String? idParser(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null) return null;

  // Case 1: Standard watch?v=ID
  if (uri.queryParameters.containsKey('v')) {
    return uri.queryParameters['v'];
  }

  // Case 2: youtu.be/ID
  if (uri.host.contains('youtu.be')) {
    return uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : null;
  }

  // Case 3: youtube.com/embed/ID
  if (uri.pathSegments.isNotEmpty && uri.pathSegments.contains('embed')) {
    final index = uri.pathSegments.indexOf('embed');
    if (index + 1 < uri.pathSegments.length) {
      return uri.pathSegments[index + 1];
    }
  }

  return null; // if not recognized
}
