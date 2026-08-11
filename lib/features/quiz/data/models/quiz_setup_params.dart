class QuizSetupParams {
  final int subcategoryId;
  final int difficulty;
  final int numberOfQuestions;

  QuizSetupParams({
    required this.subcategoryId,
    required this.difficulty,
    required this.numberOfQuestions,
  });

  Map<String, dynamic> toJson() {
    return {
      'subcategory_id': subcategoryId,
      'difficulty': difficulty,
      'number_of_questions': numberOfQuestions,
    };
  }
}
