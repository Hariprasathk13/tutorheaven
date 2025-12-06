import 'package:get/get.dart';
import 'package:tutorheaven/app/data/repositories/SummaryRepository.dart';
import 'package:tutorheaven/app/modules/Summary/controllers/SummaryController.dart';
import 'package:tutorheaven/app/modules/Transcript/controllers/TranscriptController.dart';

class SummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SummaryRepository());
    Get.lazyPut(() => SummaryController(
        summaryRepository: Get.find<SummaryRepository>(),
        transcriptController: Get.find<TranscriptController>()));
  }
}
