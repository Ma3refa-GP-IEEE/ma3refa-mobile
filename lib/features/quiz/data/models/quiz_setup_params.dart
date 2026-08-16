class QuizSetupParams {
  final int subcategoryId;
  final String difficulty;
  final int numberOfQuestions;
  final List<String>? allowedTopics;

  QuizSetupParams({
    required this.subcategoryId,
    required this.difficulty,
    required this.numberOfQuestions,
    this.allowedTopics,
  });

  Map<String, dynamic> toJson() {
    return {
      'subcategory_id': subcategoryId,
      'difficulty': difficulty,
      'number_of_questions': numberOfQuestions,
      'allowed_topics': allowedTopics,
    };
  }
}
