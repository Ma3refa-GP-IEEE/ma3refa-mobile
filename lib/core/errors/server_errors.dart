import 'package:ma3refa_mobile/features/auth/data/models/failuer_model.dart';

class ServerException implements Exception {
  final FailuerModel failureModel;
  final int? statusCode;

  ServerException({required this.failureModel, this.statusCode});

  @override
  String toString() {
    if (failureModel.errors != null && failureModel.errors!.isNotEmpty) {
      final firstErrorKey = failureModel.errors!.keys.first;
      return failureModel.errors![firstErrorKey]![0];
    }
    return failureModel.message;
  }
}
