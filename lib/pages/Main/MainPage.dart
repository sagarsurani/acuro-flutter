

import 'package:acuro/components/Common/CommonSplashBackView.dart';
import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/core/constants/ImageConstants.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../components/Common/AnimatedSwitcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var appText = AppLocalizations.of(context)!;
    return CommonSplashBackView(
      child: SmoothView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageConstants.icAppLogo,
            ),
            SizedBox(height: 12.h),
            Text(appText.welcome_to_acuro,
                style: textWith40W500WithGradient([
                  ColorConstants.blueShader,
                  ColorConstants.blueLight
                ])),
          ],
        ),
      ),
    );;
  }
}
