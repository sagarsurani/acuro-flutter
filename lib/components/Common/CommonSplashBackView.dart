import 'package:acuro/core/theme/AppColors.dart';
import 'package:flutter/material.dart';

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
