
import 'package:acuro/components/Common/RouteComponent.dart';
import 'package:auto_route/auto_route.dart';
import 'AppRouter.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    autoRouteComponent(page: SplashRoute.page,initial: true),
    autoRouteComponent(page: GetStartedRoute.page),
    autoRouteComponent(page: PhoneRegistrationRoute.page),
    autoRouteComponent(page: OtpVerifyRoute.page),
    autoRouteComponent(page: EmailVerificationRoute.page),
    autoRouteComponent(page: TakeUserDetailsRoute.page),
    autoRouteComponent(page: CreatePasswordRoute.page),
    autoRouteComponent(page: SelectRoleRoute.page),
    autoRouteComponent(page: SelectCommodityRoute.page,),
    autoRouteComponent(page: CommodityConfirmationRoute.page),
    autoRouteComponent(page: LoginRoute.page),
    autoRouteComponent(page: ForgotPasswordRoute.page),
    autoRouteComponent(page: ForgotOtpRoute.page),
    autoRouteComponent(page: ResetPasswordRoute.page),
    autoRouteComponent(page: MainRoute.page),
  ];
}
