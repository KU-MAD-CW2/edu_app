import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TermsInputField extends ConsumerWidget {
  final bool isTermsAccepted;
  final StateProvider isTermsAcceptedProvider;

  const TermsInputField(this.isTermsAccepted, this.isTermsAcceptedProvider,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Checkbox(
          value: isTermsAccepted,
          onChanged: (value) {
            ref.read(isTermsAcceptedProvider.notifier).state = value!;
          },
          checkColor: Colors.white,
          fillColor: isTermsAccepted
              ? WidgetStateProperty.all(Theme.of(context).primaryColor)
              : null,
          activeColor: Theme.of(context).primaryColor,
          side: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text('Agree with '),
        GestureDetector(
          onTap: () {
            // Handle Terms and Conditions
          },
          child: Text(
            'Terms & Condition',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
