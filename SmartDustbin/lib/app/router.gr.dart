// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/home/home_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/signin/signin_view.dart';
import '../ui/views/startup/startup_view.dart';

class Routes {
  static const String startup = '/';
  static const String signin = '/signin';
  static const String home = '/home';
  static const String login = '/login';
  static const all = <String>{
    startup,
    signin,
    home,
    login,
  };
}

class MainRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startup, page: StartupView),
    RouteDef(Routes.signin, page: SignInView),
    RouteDef(Routes.home, page: HomeView),
    RouteDef(Routes.login, page: LoginView),
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
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
  };
}
