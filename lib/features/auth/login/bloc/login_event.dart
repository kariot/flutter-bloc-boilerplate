part of 'login_bloc.dart';

@freezed
sealed class LoginEvent with _$LoginEvent {
  const factory LoginEvent.loginPressed(
      {required String username,
      required String password}) = _LoginButtonPressed;
}
