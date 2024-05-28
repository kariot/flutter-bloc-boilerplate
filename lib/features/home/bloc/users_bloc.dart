import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_boilerplate/features/auth/login/bloc/login_bloc.dart';
import 'package:bloc_boilerplate/features/home/model/users_list_response/user_data.dart';
import 'package:bloc_boilerplate/infrastructure/repositories/users/i_users_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'users_event.dart';
part 'users_state.dart';
part 'users_bloc.freezed.dart';

@injectable
class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final IUsersRepo _repo;
  UsersBloc(this._repo) : super(const UsersLoading()) {
    on<_ListUsers>(_listUsers);
  }

  FutureOr<void> _listUsers(_ListUsers event, Emitter<UsersState> emit) async {
    emit(const UsersState.loading());
    final usersResponse = await _repo.getUsersList();
    usersResponse.fold(
      (l) => emit(UsersState.failed(error: l.message)),
      (r) => emit(UsersState.success(data: r.data ?? [])),
    );
  }
}
