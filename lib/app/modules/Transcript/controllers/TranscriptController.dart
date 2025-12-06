import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:tutorheaven/app/data/models/States/states.dart';
import 'package:tutorheaven/app/data/models/Transcript/Transcript.dart';
import 'package:tutorheaven/app/data/repositories/TranscriptRepository.dart';

class TranscriptController extends GetxController {
  TranscriptRepository transcriptRepository;
  TranscriptController({required this.transcriptRepository});

  Rx<Appstate> state = Appstate.initial.obs;
  RxString error = "".obs;
  late String videoid = "";
  List<Transcript> transcript = [];
  Rx<Duration> currentTime = const Duration(seconds: 0).obs;

  void toggleLoading(Appstate newState) {
    state.value = newState;
  }

  void getTranscripts(String videoId) async {
    try {
      toggleLoading(Appstate.loading);
      videoid = videoId;
      final res = await transcriptRepository.getTranscript(videoId);
      transcript = res;
      toggleLoading(Appstate.success);
    } catch (e) {
      toggleLoading(Appstate.error);
      error.value = e.toString();
    }
  }
}
