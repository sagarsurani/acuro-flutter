import 'package:acuro/components/Common/CommonSplashBackView.dart';
import 'package:acuro/core/constants/ImageConstants.dart';
import 'package:acuro/core/navigator/AppRouter.gr.dart';
import 'package:acuro/core/theme/AppColors.dart';
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

  void navigateToGetStartedPage(){
    context.router.replace(const GetStartedRoute());
  } 

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      navigateToGetStartedPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonSplashBackView(
        child: Center(
          child: SvgPicture.asset(
            ImageConstants.icAppLogo,
          ),
        ),
      ),
    );
  }
}
