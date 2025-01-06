import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String name;
  final VoidCallback? onPressed;
  const PrimaryButton(this.name, {super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onPressed: onPressed,
      child: Text(name,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              )),
    );
  }
}
