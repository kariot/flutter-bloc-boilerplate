import 'package:freezed_annotation/freezed_annotation.dart';
part '../model/api_failure.freezed.dart';

@freezed
class ApiFailure with _$ApiFailure {
  const factory ApiFailure.serverError(
      {required String message,
      int? errorCode,
      String? validationMessage}) = _ServerError;
  const factory ApiFailure.clientError(
      {required String message,
      int? errorCode,
      String? validationMessage}) = _ClientError;
}
