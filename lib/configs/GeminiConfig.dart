import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class GeminiConfig {
  static final String baseUrl = dotenv.env['GEMINI_BASEURL']!;
  static final options = {
    'x-goog-api-key': dotenv.env['x_goog_api_key']!,
    'Content-Type': 'application/json'
  };
  static final List<Map<String, dynamic>> body = [
    {
      "role": "user",
      "parts": [
        {
          "text":
              "hi ready for conversation? this is simpler conversation between us. Always give response below."
        }
      ]
    },
    {
      "role": "model",
      "parts": [
        {"text": "yes I'm always ready!"}
      ]
    }
  ];

  static Map<String, dynamic> quizConfig = {
    "generationConfig": {
      "responseMimeType": "application/json",
      "responseSchema": {
        "type": "object",
        "properties": {
          "questions": {
            "type": "array",
            "items": {
              "type": "object",
              "properties": {
                "question": {"type": "string"},
                "options": {
                  "type": "array",
                  "items": {"type": "string"}
                },
                "answer": {"type": "string"},
                "explanation": {"type": "string"}
              },
              "required": ["question", "options", "answer"]
            }
          }
        },
        "required": ["questions"]
      }
    }
 
  };
}
