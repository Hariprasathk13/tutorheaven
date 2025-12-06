import 'package:get/get.dart';
import 'package:tutorheaven/app/data/repositories/QuizRepository.dart';
import 'package:tutorheaven/app/modules/Quiz/controllers/QuizController.dart';
import 'package:tutorheaven/app/modules/Transcript/controllers/TranscriptController.dart';

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuizRepository());

    Get.lazyPut(() => QuizController(
          transcriptController: Get.find<TranscriptController>(),
          quizRepository: Get.find<QuizRepository>(),
        ));
  }
}
