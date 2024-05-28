import 'package:bloc_boilerplate/features/auth/login/model/login_response/login_response.dart';
import 'package:bloc_boilerplate/shared/model/api_failure.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepo {
  Future<Either<ApiFailure, LoginResponse>> loginUser(
      String username, String password);
}
