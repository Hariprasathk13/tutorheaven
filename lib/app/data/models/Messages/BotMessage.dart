

import 'package:tutorheaven/app/data/models/Messages/Message.dart';

class BotMessage extends Message {
  BotMessage(super.message);

  @override
  Map toJson() {
    return {
      "role": "Model",
      "parts": [
        {"text": message}
      ]
    };
  }

  @override
  Message fromjson(Map<String, String> json) {
    return BotMessage('');
  }
}
