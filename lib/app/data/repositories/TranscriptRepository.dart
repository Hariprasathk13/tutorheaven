import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tutorheaven/app/data/models/Transcript/Transcript.dart';
import 'package:tutorheaven/common/utils/Exceptions/ServerDownException.dart';
import 'package:tutorheaven/common/utils/Exceptions/TranscriptNotFoundException.dart';
import 'package:tutorheaven/common/utils/TranscriptParser.dart';
import 'package:tutorheaven/configs/TranscriptorConfig.dart';


class TranscriptRepository{
  Future<List<Transcript>> getTranscript(String videoid) async {
    Uri url = Uri.parse(TranscriptorConfig.getUrl(videoid));

    try {
      final response = await http
          .get(url, headers: TranscriptorConfig.options)
          .timeout(const Duration(seconds: 25));

      if (response.statusCode != 200) {
        throw ServerDownException();
      }

      List data = json.decode(response.body);

      final String subtitles = data[0]['subtitle']!;

      if (subtitles == "") {
        throw TranscriptNotFoundException();
      }

      return await Transcriptparse(subtitles);
    } catch (e) {
      rethrow;
    }
  }

}
