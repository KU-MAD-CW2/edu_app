import 'package:edu_app/app/routes/routes.dart';
import 'package:edu_app/common/fields/password_input_field.dart';
import 'package:edu_app/common/fields/primary_button.dart';
import 'package:edu_app/common/fields/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final isPasswordVisibleProvider = StateProvider<bool>((ref) => false);

class LoginForm extends ConsumerWidget {
  LoginForm({
    super.key,
  });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPasswordVisible = ref.watch(isPasswordVisibleProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextInputField("Email", 'example@gmail.com'),
          SizedBox(height: 20),
          PasswordInputField("Password", '*********', isPasswordVisible,
              isPasswordVisibleProvider),
          SizedBox(height: 20),
          PrimaryButton("Sign In", onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Handle Sign Up
            }
          }),
          SizedBox(height: 40),
          _handleRegister(context),
        ],
      ),
    );
  }

  Row _handleRegister(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Don\'t have an account? ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                )),
        GestureDetector(
          onTap: () {
            context.replaceNamed(registerRoute.name as String);
          },
          child: Text(
            'Register',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }
}
