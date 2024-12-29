import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppSafeArea extends StatelessWidget {
  final Widget child;

  const AppSafeArea({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.transparent));

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);

    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: SafeArea(
        child: Container(
          color: Theme.of(context).canvasColor,
          child: child,
        ),
      ),
    );
  }
}
