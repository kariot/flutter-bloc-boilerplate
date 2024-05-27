import 'package:auto_route/auto_route.dart';
import 'package:bloc_boilerplate/shared/textfield_validators.dart';
import 'package:bloc_boilerplate/shared/ui/common_widget_props.dart';
import 'package:bloc_boilerplate/shared/ui/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'kminchelle');
  final _passwordController = TextEditingController(text: '0lelplR');
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
                  PrimaryButton(
                      isLoading: false,
                      onPressed: _onPressSignIn,
                      title: 'Sign in')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  _onPressSignIn() {}
}
