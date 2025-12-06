import 'package:get/get.dart';
import 'package:tutorheaven/app/data/repositories/TranscriptRepository.dart';
import 'package:tutorheaven/app/modules/Transcript/controllers/TranscriptController.dart';

class TranscriptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TranscriptRepository());
    Get.lazyPut(() => TranscriptController(
        transcriptRepository: Get.find<TranscriptRepository>()));
  }
}
