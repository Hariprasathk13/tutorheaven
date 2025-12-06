import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tutorheaven/common/utils/Exceptions/ServerDownException.dart';
import 'package:tutorheaven/configs/GeminiConfig.dart';

class SummaryRepository {
  Future getSummary(String transcripts) async {
    Uri url = Uri.parse(GeminiConfig.baseUrl);
    var body = {
      "contents": [
        {
          "parts": [
            {
              "text":
                  """Create a 3 -5 lines summary on below transcript transcript: .
                  $transcripts
                  """
            }
          ]
        }
      ]
    };

    try {
      final response = await http.post(url,
          headers: GeminiConfig.options, body: json.encode(body));

      if (response.statusCode != 200) {
        throw ServerDownException();
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final res = data['candidates']![0]['content']!['parts']![0]['text']!;
        return res;
      }
    } catch (e) {
      rethrow;
    }
  }
}
