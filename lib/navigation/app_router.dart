import 'package:auto_route/auto_route.dart';
import 'package:bloc_boilerplate/features/auth/login/views/login_screen.dart';
import 'package:bloc_boilerplate/navigation/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
      ];
}
