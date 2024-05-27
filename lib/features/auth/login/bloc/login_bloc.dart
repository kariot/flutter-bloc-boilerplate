import 'package:bloc/bloc.dart';
import 'package:bloc_boilerplate/features/auth/login/model/login_response.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState.initial()) {
    on<_LoginButtonPressed>((event, emit) async {
      final username = event.username;
      final password = event.password;
      emit(const LoginState.loading());
      await Future.delayed(
        const Duration(seconds: 5),
      );
      emit(
        LoginState.success(
          LoginResponse(),
        ),
      );
    });
  }
}
