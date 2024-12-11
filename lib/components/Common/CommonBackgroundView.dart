

import 'package:acuro/core/theme/AppColors.dart';
import 'package:flutter/material.dart';

class CommonBackgroundView extends StatelessWidget {
  final Widget child;
  const CommonBackgroundView({super.key, required this.child});

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
            ColorConstants.white1,
            ColorConstants.white1,
          ],
          stops: [0.0, 0.2, 1.0],
        ),
      ),
      child: child,
    );
  }
}
