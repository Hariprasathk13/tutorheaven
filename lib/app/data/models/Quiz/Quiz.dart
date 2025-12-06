class Question {
  final String question;
  final List<String> options;
  final String answer;
  final String? explanation;

  Question({
    required this.question,
    required this.options,
    required this.answer,
    this.explanation,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      answer: json['answer'] ?? '',
      explanation: json['explanation'],
    );
  }

  Map<String, dynamic> toJson() => {
        'question': question,
        'options': options,
        'answer': answer,
        if (explanation != null) 'explanation': explanation,
      };
}

class Quiz {
  final List<Question> questions;

  Quiz({required this.questions});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    final List<dynamic> questionList = json['questions'] ?? [];
    return Quiz(
      questions:
          questionList.map((q) => Question.fromJson(q)).toList(growable: false),
    );
  }

  Map<String, dynamic> toJson() => {
        'questions': questions.map((q) => q.toJson()).toList(),
      };
}
