class ResultParams {
  final int subcategoryId;
  final int score;
  final List<Answer> answers;

  ResultParams({
    required this.subcategoryId,
    required this.score,
    required this.answers,
  });

  Map<String, dynamic> toJson() {
    return {
      'subcategory_id': subcategoryId,
      'score': score,
      'answers': answers.map((answer) => answer.toJson()).toList(),
    };
  }
}

class Answer {
  final int questionId;
  final String? selectedAnswer;
  final bool isCorrect;

  Answer({
    required this.questionId,
    required this.selectedAnswer,
    required this.isCorrect,
  });

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'selected_answer': selectedAnswer,
      'is_correct': isCorrect,
    };
  }
}
