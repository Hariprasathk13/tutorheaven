import 'dart:convert';

import 'package:tutorheaven/app/data/models/Messages/BotMessage.dart';
import 'package:tutorheaven/common/utils/Exceptions/ServerDownException.dart';
import 'package:tutorheaven/configs/GeminiConfig.dart';

import 'package:http/http.dart' as http;

class ChatRepository {
  Future<Map<String, dynamic>> getResponse(String query, String summary) async {
    Uri url = Uri.parse(GeminiConfig.baseUrl);
    final List<Map<String, dynamic>> contents = [
      ...GeminiConfig.body.map((e) => Map<String, dynamic>.from(e)),
    ];

    contents[1]['parts'][0]['text'] = "Previous summary:" + summary;
    contents[0]['parts'][0]['text'] =
        "Summarize the conversation so far and answer this new question:" +
            query;
    final config = {
      "generationConfig": {
        "responseMimeType": "application/json",
        "responseSchema": {
          "type": "object",
          "properties": {
            "answer": {"type": "string"},
            "summary": {"type": "string"}
          },
          "required": ["answer", "summary"]
        }
      }
    };

    final body = {"contents": contents, ...config};

    try {
      final response = await http.post(url,
          headers: GeminiConfig.options, body: json.encode(body));

      if (response.statusCode != 200) {
        throw ServerDownException();
      }

      final data = json.decode(response.body);
      final text =
          data['candidates'][0]['content']['parts'][0]['text'] as String;

// Decode it into a Dart Map
      final parsed = jsonDecode(text);

      final res = parsed['answer'] as String;
      final chatsummary = parsed['summary'] as String;

      return {"answer": BotMessage(res.toString()), "summary": chatsummary};
    } catch (e) {
      rethrow;
    }
  }
}
