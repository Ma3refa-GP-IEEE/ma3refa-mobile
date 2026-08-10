class FailuerModel {
  final int statusCode;
  final String message;

  FailuerModel({required this.statusCode, required this.message});

  factory FailuerModel.fromJson(Map<String, dynamic> json) {
    return FailuerModel(
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson(FailuerModel failuerModel) {
    return {
      'statusCode': failuerModel.statusCode,
      'message': failuerModel.message,
    };
  }
}
