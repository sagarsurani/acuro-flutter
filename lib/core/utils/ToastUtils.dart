
import 'package:acuro/core/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';
import '../../components/Common/CommonTextStyle.dart';

class ToastUtils {

  static void showToaster(String message, BuildContext context) {
    toastFun(context,message);
  }

  static void toastFun(BuildContext context,String messageText) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,
      animationDuration: const Duration(milliseconds: 100),
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.bottomLeft,
      direction: TextDirection.ltr,
      primaryColor: ColorConstants.red,
      backgroundColor: ColorConstants.white1,
      borderRadius: BorderRadius.circular(12.r),
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.none,
      progressBarTheme: const ProgressIndicatorThemeData(
          circularTrackColor: Colors.transparent,
          linearMinHeight: 0,
          linearTrackColor: Colors.transparent),
      description: Text(messageText, style: textWith14W500(ColorConstants.red)),
      icon: Container(),
      closeOnClick: false,
      dragToClose: true,
    );
  }
}
