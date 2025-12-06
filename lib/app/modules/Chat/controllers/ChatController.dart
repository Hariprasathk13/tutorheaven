import 'package:get/get.dart';
import 'package:tutorheaven/app/data/models/Messages/Message.dart';
import 'package:tutorheaven/app/data/models/Messages/UserMessage.dart';
import 'package:tutorheaven/app/data/models/States/states.dart';
import 'package:tutorheaven/app/data/repositories/ChatRepository.dart';
import 'package:tutorheaven/app/modules/Summary/controllers/SummaryController.dart';


class ChatController extends GetxController {
  RxList<Message> messages = <Message>[].obs;
  Rx<Appstate> appstate = Appstate.initial.obs;
  Rx<ChatState> typingstate = ChatState.idle.obs;
  RxBool canSend = false.obs;
  RxString error = "".obs;

  late String summary;
  ChatRepository chatRepository;
  ChatController(this.chatRepository);

  @override
  void onInit() {
    final SummaryController summaryController = Get.find<SummaryController>();
    summary = summaryController.summary.message;
    super.onInit();
  }

  void addMessage(Message message) {
    messages.add(message);
  }

  List<Message> get chats => messages.toList();
  void toogleLoading(Appstate newstate) {
    appstate.value = newstate;
  }

  void send(Message message) async {
    try {
      addMessage(message);
      toogleLoading(Appstate.loading);

      final response = await chatRepository.getResponse(message.message, summary);
      final Message geminiresponse = response['answer']
      ;
      
      final String geminisummary = response['summary'];
      summary = geminisummary;

      toogleLoading(Appstate.success);
      addMessage(geminiresponse);
    } catch (e) {
      error.value = e.toString();
      toogleLoading(Appstate.error);
    }
  }

  void askGemini(String message) {
    send(UserChat(message));
  }
}
