import 'package:edu_app/app/routes/routes.dart';
import 'package:edu_app/common/fields/password_input_field.dart';
import 'package:edu_app/common/fields/primary_button.dart';
import 'package:edu_app/common/fields/terms_input_field.dart';
import 'package:edu_app/common/fields/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final isPasswordVisibleProvider = StateProvider<bool>((ref) => false);
final isTermsAcceptedProvider = StateProvider<bool>((ref) => false);

class RegisterForm extends ConsumerWidget {
  RegisterForm({
    super.key,
  });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPasswordVisible = ref.watch(isPasswordVisibleProvider);
    final isTermsAccepted = ref.watch(isTermsAcceptedProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextInputField('Name', "Ex. John Doe"),
          SizedBox(height: 20),
          TextInputField("Email", 'example@gmail.com'),
          SizedBox(height: 20),
          PasswordInputField("Password", '*********', isPasswordVisible,
              isPasswordVisibleProvider),
          SizedBox(height: 20),
          TermsInputField(isTermsAccepted, isTermsAcceptedProvider),
          SizedBox(height: 20),
          PrimaryButton("Sign Up", onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Handle Sign Up
            }
          }),
          SizedBox(height: 40),
          _handleLogin(context),
        ],
      ),
    );
  }

  Row _handleLogin(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account? ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                )),
        GestureDetector(
          onTap: () {
            context.replaceNamed(loginRoute.name as String);
          },
          child: Text(
            'Sign In',
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
