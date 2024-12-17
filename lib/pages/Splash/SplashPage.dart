import 'package:acuro/components/Common/AnimatedSwitcher.dart';
import 'package:acuro/components/Common/CommonSplashBackView.dart';
import 'package:acuro/core/constants/ImageConstants.dart';
import 'package:acuro/core/navigator/AppRouter.gr.dart';
import 'package:acuro/core/persistence/PreferenceHelper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      navigateToGetStartedPage();
    });
  }

  // Future<void> checkConditionAndNavigation() async {
  //   bool isLogin = await PreferenceHelper.getIsLogin();
  //   String? accessToken = await PreferenceHelper.getAccessToken();
  //   if (accessToken != null) {
  //     if(isLogin){
  //       navigateToMainPage();
  //     } else {
  //       navigateToRoleSelectionPage();
  //     }
  //   } else {
  //     navigateToGetStartedPage();
  //   }
  // }

  void navigateToGetStartedPage() {
    context.router.replace(const GetStartedRoute());
  }

  void navigateToMainPage() {
    context.router.replace(const MainRoute());
  }

  void navigateToRoleSelectionPage() {
    context.router.replace(const SelectRoleRoute());
  }

  @override
  Widget build(BuildContext context) {
    return CommonSplashBackView(
      child: Center(
        child: SmootherView(
          child: SvgPicture.asset(
            ImageConstants.icAppLogo,
          ),
        ),
      ),
    );
  }
}
