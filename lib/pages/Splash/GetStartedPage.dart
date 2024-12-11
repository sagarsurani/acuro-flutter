
import 'package:acuro/components/Common/AnimatedSwitcher.dart';
import 'package:acuro/components/Common/CommonButton.dart';
import 'package:acuro/components/Common/CommonSplashBackView.dart';
import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/core/constants/ImageConstants.dart';
import 'package:acuro/core/navigator/AppRouter.gr.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {

  void navigateToRegistrationRoute(){
    context.router.push(const PhoneRegistrationRoute());
  }

  void navigateToLoginRoute(){
    context.router.push(const LoginRoute());
  }

  @override
  Widget build(BuildContext context) {
    var appText = AppLocalizations.of(context)!;
    return Scaffold(
      body: CommonSplashBackView(
        child: Padding(
          padding: EdgeInsets.only(top: 100.h, bottom: 48.h),
          child: SmoothView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(ImageConstants.icAppLogo,
                          height: 49.h, width: 64.w),
                      SizedBox(height: 79.h),
                      Text(appText.predict,
                          style: textWith40W500WithGradient(
                              [ColorConstants.blueShader, ColorConstants.blueLight])),
                      Text(appText.with_confidence,
                          style: textWith40W700(ColorConstants.blueDark))
                    ],
                  ),
                ),
                SizedBox(height: 37.h),
                Image.asset(ImageConstants.imgGraph, height: 252.h),
                const Spacer(),
                CommonButton(
                    onTap: navigateToRegistrationRoute,
                    buttonText: appText.get_started,
                    margin: EdgeInsets.symmetric(horizontal: 20.w)),
                SizedBox(height: 12.h),
                CommonButton(
                    onTap: navigateToLoginRoute,
                    buttonText: appText.log_in,
                    backGroundColor: ColorConstants.blueLight01,
                    textStyle: textWith16W700(ColorConstants.blue),
                    margin: EdgeInsets.symmetric(horizontal: 20.w))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
