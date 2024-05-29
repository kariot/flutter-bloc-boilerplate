import 'dart:async';

import 'package:bloc_boilerplate/features/auth/login/model/login_response/login_response.dart';
import 'package:bloc_boilerplate/infrastructure/repositories/auth/i_auth_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthRepo repo;
  LoginBloc(this.repo) : super(const LoginState.initial()) {
    // on<_LoginButtonPressed>(_loginUser);
    on<_LoginButtonPressed>(_loginUser);
  }

  FutureOr<void> _loginUser(
      _LoginButtonPressed event, Emitter<LoginState> emit) async {
    final username = event.username;
    final password = event.password;
    emit(const LoginState.loading());
    final loginResponse = await repo.loginUser(username, password);
    loginResponse.fold(
      (l) => emit(LoginState.failure(l.message)),
      (r) => emit(LoginState.success(r)),
    );
  }
}
