
import 'package:acuro/components/Common/RouteComponent.dart';
import 'package:acuro/pages/Login/PhoneRegistrationPage.dart';
import 'package:auto_route/auto_route.dart';
import 'AppRouter.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    autoRouteComponent(page: SplashRoute.page,initial: true),
    autoRouteComponent(page: GetStartedRoute.page),
    autoRouteComponent(page: PhoneRegistrationRoute.page),
    autoRouteComponent(page: OtpVerifyRoute.page)
  ];
}
