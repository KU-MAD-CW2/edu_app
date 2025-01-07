import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextInputField extends ConsumerWidget {
  final String label;
  final String placeholder;
  final TextEditingController? controller;
  final void Function(dynamic value)? onChanged;

  const TextInputField(this.label, this.placeholder,
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
          validator: (value) => value!.isEmpty ? 'Please enter $label!' : null,
          controller: onChanged == null ? controller : null,
          onChanged: (value) => {
            controller?.text = value,
            if (onChanged != null)
              {
                onChanged!(value),
              }
          },
          decoration: InputDecoration(
            hintText: placeholder,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
          ),
        ),
      ],
    );
  }
}
