// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../datamodels/dustbin_model.dart';
import '../ui/views/dustbin/dustbin_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/signin/signin_view.dart';
import '../ui/views/startup/startup_view.dart';

class Routes {
  static const String startup = '/';
  static const String signin = '/signin';
  static const String home = '/home';
  static const String dustbin = '/dustbin';
  static const all = <String>{
    startup,
    signin,
    home,
    dustbin,
  };
}

class MainRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startup, page: StartupView),
    RouteDef(Routes.signin, page: SignInView),
    RouteDef(Routes.home, page: HomeView),
    RouteDef(Routes.dustbin, page: DustbinView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    StartupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StartupView(),
        settings: data,
      );
    },
    SignInView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignInView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    DustbinView: (data) {
      final args = data.getArgs<DustbinViewArguments>(
        orElse: () => DustbinViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => DustbinView(
          key: args.key,
          dustbin: args.dustbin,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// DustbinView arguments holder class
class DustbinViewArguments {
  final Key key;
  final DustbinModel dustbin;
  DustbinViewArguments({this.key, this.dustbin});
}
