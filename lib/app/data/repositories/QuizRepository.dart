import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutorheaven/app/data/models/Quiz/Quiz.dart';
import 'package:tutorheaven/app/data/models/Transcript/Transcript.dart';
import 'package:tutorheaven/common/utils/Exceptions/ServerDownException.dart';
import 'package:tutorheaven/configs/GeminiConfig.dart';


class QuizRepository {
  Future<Quiz> getQuiz(List<Transcript> transcripts) async {
    final String transcript = transcripts.map((e) => e.text).join(' ');

    final body = {
      "contents": [
        {
          "role": "user",
          "parts": [
            {
              "text":
                  "Generate a quiz with 5 questions from the following context. Return only JSON in structured format:\n\n$transcript"
            }
          ]
        }
      ],
      ...GeminiConfig.quizConfig
    };

    Uri url = Uri.parse(GeminiConfig.baseUrl);
    final response = await http.post(url,
        headers: GeminiConfig.options, body: json.encode(body));
    if (response.statusCode != 200) throw ServerDownException();
    final data = jsonDecode(response.body);
    final quiz = data['candidates'][0]['content']['parts'][0]['text'];
    final parsed = json.decode(quiz);
    print(parsed);

    return Quiz.fromJson(parsed);
  }
}
