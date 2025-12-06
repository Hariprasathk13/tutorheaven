import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorheaven/app/modules/Quiz/controllers/QuizController.dart';
import 'package:tutorheaven/app/data/models/Quiz/Quiz.dart';
import 'package:tutorheaven/app/data/models/States/states.dart';
import 'package:tutorheaven/app/widgets/ErrorText.dart';
import 'package:tutorheaven/app/widgets/StateBuilder.dart';


class QuizPage extends StatelessWidget {
  QuizPage({super.key});
  final QuizController _quizController = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
          child: StateBuilder(
              onInitial: () => Text(""),
              state: _quizController.state,
              onLoading: () => const Center(
                    child: CircularProgressIndicator(color: Colors.blueAccent),
                  ),
              onError: () =>
                  Errortext(errorMessage: _quizController.error.value),
              onSuccess: () {
                final questions = _quizController.quiz.questions;
                final qnno = _quizController.qnno.value;
                final question = questions[qnno];
                final totalQuestions = questions.length;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Smooth Progress Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: (qnno + 1) / totalQuestions,
                          minHeight: 10,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF4A90E2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Question Header
                      Text(
                        'Question ${qnno + 1} of $totalQuestions',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Question Text
                      Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E2A78),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Options
                      Expanded(child: _buildOptions(question)),

                      // Explanation (if visible)
                      if (_quizController.canshowExplanation.isTrue)
                        AnimatedOpacity(
                          opacity: 1,
                          duration: const Duration(milliseconds: 400),
                          child: _buildExplanation(question.explanation!,
                              _quizController.answerState.value),
                        ),
                    ],
                  ),
                );
              })),
    );
  }

  Widget _buildExplanation(String explanation, AnswerState answerState) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: answerState == AnswerState.Correct
              ? [const Color(0xFF4CAF50), const Color(0xFF81C784)]
              : [const Color(0xFFE53935), const Color(0xFFFF7043)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Text(
        explanation,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          height: 1.4,
        ),
      ),
    );
  }

  List<Color> getcolor(bool isSelected) {
    if (!isSelected) return [const Color(0xFF6A85B6), const Color(0xFFBAC8E0)];
    final answerState = _quizController.answerState.value;

    if (answerState == AnswerState.Correct) {
      return [const Color(0xFF4CAF50), const Color(0xFF81C784)];
    }
    return [const Color(0xFFE53935), const Color(0xFFFF7043)];
  }

  Widget _buildOptions(Question question) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
        height: 20,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: question.options.length,
      itemBuilder: (context, index) {
        final option = question.options[index];
        return Obx(() {
          final isSelected = _quizController.selectedIndex.value == index;
          final answerState = _quizController.answerState.value;

          List<Color> color;
          if (isSelected) {
            if (answerState == AnswerState.Correct) {
              color = [const Color(0xFF4CAF50), const Color(0xFF81C784)];
            } else {
              color = [const Color(0xFFE53935), const Color(0xFFFF7043)];
            }
          } else {
            color = [const Color(0xFF6A85B6), const Color(0xFFBAC8E0)];
          }

          return InkWell(
            onTap: () => _quizController.nextQuestion(index),
            borderRadius: BorderRadius.circular(14),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: color),
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 18,
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
