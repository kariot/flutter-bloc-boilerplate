import 'package:auto_route/auto_route.dart';
import 'package:bloc_boilerplate/features/auth/login/bloc/login_bloc.dart';
import 'package:bloc_boilerplate/features/auth/login/model/login_response/login_response.dart';
import 'package:bloc_boilerplate/navigation/app_router.gr.dart';
import 'package:bloc_boilerplate/shared/textfield_validators.dart';
import 'package:bloc_boilerplate/shared/ui/common_widget_props.dart';
import 'package:bloc_boilerplate/shared/ui/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'eve.holt@reqres.in');
  final _passwordController = TextEditingController(text: 'cityslicka');

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 6,
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    validator: getUsernameValidator,
                    keyboardType: TextInputType.name,
                    decoration: getInputDecoration('Enter you username'),
                  ),
                  const Gap(20),
                  TextFormField(
                    controller: _passwordController,
                    validator: getPasswordValidator,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: getInputDecoration('Enter you password'),
                  ),
                  const Gap(20),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (ctx, state) {
                      if (state is LoginSuccess) {
                        handleSuccess(context, state.response);
                        return;
                      }
                      if (state is LoginError) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },
                    builder: (context, state) {
                      return PrimaryButton(
                          isLoading: state is LoginLoading,
                          onPressed: () => _onPressSignIn(context),
                          title: 'Sign in');
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onPressSignIn(BuildContext ctx) {
    if (_formKey.currentState?.validate() == false) {
      return;
    }
    final username = _usernameController.text.toString();
    final password = _passwordController.text.toString();
    ctx
        .read<LoginBloc>()
        .add(LoginEvent.loginPressed(username: username, password: password));
  }

  void handleSuccess(BuildContext ctx, LoginResponse response) {
    ctx.router.replace(const HomeRoute());
  }
}
