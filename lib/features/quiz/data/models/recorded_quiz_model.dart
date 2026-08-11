class RecordedQuizModel {
  final int statusCode;
  final String message;
  RecordedQuizModel({required this.statusCode, required this.message});

  factory RecordedQuizModel.fromJson(Map<String, dynamic> json) {
    return RecordedQuizModel(
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}
