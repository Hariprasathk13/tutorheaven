import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:tutorheaven/app/data/repositories/ChatRepository.dart';
import 'package:tutorheaven/app/modules/Chat/controllers/ChatController.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChatRepository());
    Get.lazyPut(() => ChatController(Get.find<ChatRepository>()));
  }
}
