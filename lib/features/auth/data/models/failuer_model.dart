class FailuerModel {
  final String message;
  final Map<String, dynamic>? errors;
  FailuerModel({required this.message, this.errors});

  factory FailuerModel.fromJson(Map<String, dynamic> json) {
    return FailuerModel(
      message: json['message'] ?? 'Unknown error occurred',
      errors: json['errors'],
    );
  }
}
