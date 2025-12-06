class TranscriptNotFoundException implements Exception {
  @override
  String toString() {
    return "Transcript not found for given video";
  }
}
