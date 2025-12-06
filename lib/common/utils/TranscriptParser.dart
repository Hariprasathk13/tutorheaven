import 'package:tutorheaven/app/data/models/Transcript/Transcript.dart';

Duration parseDuration(String time) {
  // Format: HH:MM:SS,mmm
  final parts = time.split(',');
  final hms = parts[0].split(':');

  final hours = int.parse(hms[0]);
  final minutes = int.parse(hms[1]);
  final seconds = int.parse(hms[2]);
  final milliseconds = int.parse(parts[1]);

  return Duration(
    hours: hours,
    minutes: minutes,
    seconds: seconds,
    milliseconds: milliseconds,
  );
}

Future<List<Transcript>> Transcriptparse(String subtitles) async {
  List<Transcript> structuredSubtitles = [];
  RegExp regExp = RegExp(
      r'(\d+)\n(\d{2}:\d{2}:\d{2},\d{3}) --> (\d{2}:\d{2}:\d{2},\d{3})\n([\s\S]*?)(?=\n\d+\n|$)',
      multiLine: true);

  for (final match in regExp.allMatches(subtitles)) {
    structuredSubtitles.add(Transcript(
        id: int.parse(match.group(1)!),
        startTime: parseDuration(match.group(2)!),
        endTime: parseDuration(match.group(2)!),
        text: match.group(4)!.replaceAll('\n', ' ').trim()));
  }
  return structuredSubtitles;
}
