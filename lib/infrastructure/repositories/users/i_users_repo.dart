import 'package:bloc_boilerplate/features/home/model/users_list_response/users_list_response.dart';
import 'package:bloc_boilerplate/shared/model/api_failure.dart';
import 'package:dartz/dartz.dart';

abstract class IUsersRepo {
  Future<Either<ApiFailure, UsersListResponse>> getUsersList();
}
