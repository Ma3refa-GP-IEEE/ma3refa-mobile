class PaginationModel {
  final int currentPage;
  final int perPage;
  final int totalQuizzes;
  final int totalPages;

  PaginationModel({
    required this.currentPage,
    required this.perPage,
    required this.totalQuizzes,
    required this.totalPages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current_page'],
      perPage: json['per_page'],
      totalQuizzes: json['total_quizzes'],
      totalPages: json['total_pages'],
    );
  }
}
