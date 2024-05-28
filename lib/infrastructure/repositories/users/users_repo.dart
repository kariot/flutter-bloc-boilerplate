import 'package:bloc_boilerplate/features/home/model/users_list_response/users_list_response.dart';
import 'package:bloc_boilerplate/infrastructure/base/base_repo.dart';
import 'package:bloc_boilerplate/infrastructure/repositories/users/i_users_repo.dart';
import 'package:bloc_boilerplate/shared/model/api_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IUsersRepo)
class UsersRepo extends IUsersRepo with BaseRepo {
  @override
  Future<Either<ApiFailure, UsersListResponse>> getUsersList() async {
    const url = "https://reqres.in/api/users?page=2";
    return super.get(
      url,
      (p0) => UsersListResponse.fromJson(p0 ?? {}),
    );
  }
}
