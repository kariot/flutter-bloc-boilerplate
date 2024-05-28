import 'package:bloc_boilerplate/features/auth/login/model/login_response/login_response.dart';
import 'package:bloc_boilerplate/infrastructure/base/base_repo.dart';
import 'package:bloc_boilerplate/infrastructure/repositories/auth/i_auth_repo.dart';
import 'package:bloc_boilerplate/shared/model/api_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IAuthRepo)
class AuthRepo extends IAuthRepo with BaseRepo {
  @override
  Future<Either<ApiFailure, LoginResponse>> loginUser(
      String username, String password) async {
    const url = 'https://reqres.in/api/login';
    final body = {
      'email': username,
      'password': password,
    };
    return super.post(
      url,
      body,
      (p0) => LoginResponse.fromJson(p0 ?? {}),
    );
  }
}
