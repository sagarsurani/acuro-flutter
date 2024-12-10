
import 'package:acuro/core/constants/ImageConstants.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonSplashBackView extends StatelessWidget {
  final Widget child;
  const CommonSplashBackView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorConstants.splashGradient1,
            ColorConstants.splashGradient2,
          ],
        ),
      ),
      child: child,
    );
  }
}

class CommonBackView extends StatelessWidget {
  final VoidCallback onTap;
  const CommonBackView({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap, child: SizedBox(child: SvgPicture.asset(ImageConstants.icArrowLeft)));
  }
}
