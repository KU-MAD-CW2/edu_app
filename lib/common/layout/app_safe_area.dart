import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppSafeArea extends StatelessWidget {
  final Widget child;
  final Color? appBarColor;

  const AppSafeArea({
    super.key,
    required this.child,
    this.appBarColor,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: appBarColor ?? Colors.transparent,
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
