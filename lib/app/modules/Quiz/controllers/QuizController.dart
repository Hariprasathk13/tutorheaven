import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:tutorheaven/app/data/models/Quiz/Quiz.dart';
import 'package:tutorheaven/app/data/models/States/states.dart';
import 'package:tutorheaven/app/data/models/Transcript/Transcript.dart';
import 'package:tutorheaven/app/data/repositories/QuizRepository.dart';
import 'package:tutorheaven/app/modules/Transcript/controllers/TranscriptController.dart';

class QuizController extends GetxController {
  Quiz quiz = Quiz(questions: []);

  Rx<Appstate> state = Appstate.initial.obs;
  RxString error = "".obs;

  RxBool canshowExplanation = false.obs;
  final QuizRepository _quizRepository;
  var score = 0.obs;
  var selectedIndex = (-1).obs;
  RxInt qnno = 0.obs;
  Rx<AnswerState> answerState = AnswerState.NotClicked.obs;

  final TranscriptController transcriptController;
  late List<Transcript> transcripts;
  late List<Question> questions;

  QuizController({required this.transcriptController, required QuizRepository quizRepository})
      : _quizRepository = quizRepository;

  @override
  void onInit() {
    transcripts = transcriptController.transcript;
    getQuiz();
    super.onInit();
  }

  void toogleshowExplanation() {
    canshowExplanation.value = !canshowExplanation.value;
  }

  void toggleLoading(Appstate newState) {
    state.value = newState;
  }

  void setTileColor(istrue) {
    if (istrue) {
      answerState.value = AnswerState.Correct;
    } else {
      answerState.value = AnswerState.NotCorrect;
    }
  }

  void nextQuestion(int selectanswer) async {
    selectedIndex.value = selectanswer;
    String answer = questions[qnno.value].options[selectanswer];
    bool isTrue = answer == questions[qnno.value].answer;
    setTileColor(isTrue);
    if (isTrue) {
      score++;
    }

    await Future.delayed(const Duration(milliseconds: 500));
    toogleshowExplanation();
    await Future.delayed(const Duration(seconds: 2));
    toogleshowExplanation();
    if (qnno.value == questions.length - 1) {
      Get.toNamed('/res', arguments: {'score': score.toString()});
    } else {
      qnno++;
      selectedIndex.value = -1;
    }
  }

  void getQuiz() async {
    try {
      toggleLoading(Appstate.loading);
      quiz = await _quizRepository.getQuiz(transcripts);
      questions = quiz.questions;

      toggleLoading(Appstate.success);
    } catch (e) {
      error.value = e.toString();
      toggleLoading(Appstate.error);
    }
  }
}
