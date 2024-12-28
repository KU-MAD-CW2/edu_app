import 'package:flutter/material.dart';

class AppSafeArea extends StatelessWidget {
  final Widget child;

  const AppSafeArea({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: SafeArea(
        child: child,
      ),
    );
  }
}
