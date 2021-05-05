import 'package:flutter/material.dart';
import 'package:smart_dustbin/app/app_theme.dart';
import 'package:smart_dustbin/app/router.gr.dart';
import 'package:stacked_services/stacked_services.dart';

class SmartDustbinApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Smart Dustbin",
      theme: theme,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: MainRouter().onGenerateRoute,
    );
  }
}
