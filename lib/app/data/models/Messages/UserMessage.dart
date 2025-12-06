
import 'package:tutorheaven/app/data/models/Messages/Message.dart';

class UserChat extends Message {
  UserChat(super.message);

  @override
  Map toJson() {
    return {
      "role": "User",
      "parts": [
        {"text": message}
      ]
    };
  }

  @override
  Message fromjson(Map<String, String> json) {
    return UserChat('');
  }
}
