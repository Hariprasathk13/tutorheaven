import 'package:get/get.dart';
import 'package:tutorheaven/app/data/models/States/states.dart';
import 'package:tutorheaven/app/data/models/summary/Summary.dart';
import 'package:tutorheaven/app/data/repositories/SummaryRepository.dart';
import 'package:tutorheaven/app/modules/Transcript/controllers/TranscriptController.dart';

class SummaryController extends GetxController {
  TranscriptSummary summary = TranscriptSummary("no summary");
  final SummaryRepository summaryRepository;
  final TranscriptController transcriptController;

  SummaryController(
      {required this.summaryRepository, required this.transcriptController});

  @override
  void onInit() {
    getSummary();
    super.onInit();
  }

  Rx<Appstate> state = Appstate.initial.obs;
  RxString error = "".obs;
  void toggleLoading(Appstate newState) {
    state.value = newState;
  }

  void getSummary() async {
    toggleLoading(Appstate.loading);

    try {
      final String transcripts =
          transcriptController.transcript.map((e) => e.text).join('');

      final res = await summaryRepository.getSummary(transcripts);
      summary = TranscriptSummary(res);

      toggleLoading(Appstate.success);
    } catch (e) {
      print(e);
      toggleLoading(Appstate.error);
    }
  }
}
