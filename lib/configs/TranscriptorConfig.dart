import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class TranscriptorConfig {
  static String baseurl = dotenv.env['TRANSCRIPT_BASEURL']!;
  static Map<String, String> options = {
    'x-rapidapi-key': dotenv.env['x-rapidapi-key']!,
    'x-rapidapi-host': dotenv.env['x-rapidapi-host']!
  };
  static String tailors = "?format_subtitle=srt&format_answer=json";
  static String getUrl(String id) {
    return baseurl + id + tailors;
  }
}
