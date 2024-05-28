part of 'users_bloc.dart';

@freezed
class UsersState with _$UsersState {
  const factory UsersState.loading() = UsersLoading;
  const factory UsersState.failed({required String error}) = UsersListError;
  const factory UsersState.success({required List<UserData> data}) =
      UsersListSuccess;
}
