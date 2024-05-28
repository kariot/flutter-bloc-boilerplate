import 'package:bloc_boilerplate/di/injectable.dart';
import 'package:bloc_boilerplate/features/auth/login/bloc/login_bloc.dart';
import 'package:bloc_boilerplate/features/home/bloc/users_bloc.dart';
import 'package:bloc_boilerplate/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

void main() {
  configureDependencies();
  runApp(
    MainApp(),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => getIt<LoginBloc>(),
        ),
        BlocProvider<UsersBloc>(
          create: (context) => getIt<UsersBloc>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
