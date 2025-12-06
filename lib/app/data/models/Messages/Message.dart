abstract class Message {
  String _message;
  String get message => _message;
  Message(String message) : _message = message;
  Map toJson();
  Message fromjson(Map<String, String> json);
}
