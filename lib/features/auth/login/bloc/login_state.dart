part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Init;
  const factory LoginState.loading() = LoginLoading;
  const factory LoginState.success(LoginResponse response) = LoginSuccess;
  const factory LoginState.failure(String error) = LoginError;
}
