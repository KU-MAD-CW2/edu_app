import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordInputField extends ConsumerWidget {
  final String label;
  final String placeholder;
  final bool isPasswordVisible;
  final StateProvider isPasswordVisibleProvider;
  final TextEditingController? controller;
  final void Function(dynamic value)? onChanged;

  const PasswordInputField(this.label, this.placeholder, this.isPasswordVisible,
      this.isPasswordVisibleProvider,
      {super.key, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(label,
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        TextFormField(
          controller: onChanged == null ? controller : null,
          onChanged: (value) => {
            controller?.text = value,
            if (onChanged != null)
              {
                onChanged!(value),
              }
          },
          obscureText: !isPasswordVisible,
          validator: (value) => value!.isEmpty ? 'Please enter $label!' : null,
          decoration: InputDecoration(
              hintText: placeholder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  ref.read(isPasswordVisibleProvider.notifier).state =
                      !isPasswordVisible;
                },
              )),
        ),
      ],
    );
  }
}
