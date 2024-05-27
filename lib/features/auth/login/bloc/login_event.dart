part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.loginPressed(String username, String password) =
      _LoginButtonPressed;
}
