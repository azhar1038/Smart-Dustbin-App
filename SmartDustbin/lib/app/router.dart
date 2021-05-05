import 'package:auto_route/auto_route_annotations.dart';
import 'package:smart_dustbin/ui/views/home/home_view.dart';
import 'package:smart_dustbin/ui/views/login/login_view.dart';
import 'package:smart_dustbin/ui/views/signin/signin_view.dart';
import 'package:smart_dustbin/ui/views/startup/startup_view.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(
      page: StartupView,
      name: 'startup',
      path: '/',
    ),
    MaterialRoute(
      page: SignInView,
      name: 'signin',
      path: '/signin'
    ),
    MaterialRoute(
      page: HomeView,
      name: 'home',
      path: '/home',
    ),
    MaterialRoute(
      page: LoginView,
      name: 'login',
      path: '/login',
    ),
  ],
)
class $MainRouter {}
