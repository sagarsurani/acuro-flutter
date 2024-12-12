import 'dart:async';
import 'package:acuro/components/Common/AnimatedSwitcher.dart';
import 'package:acuro/components/Common/CommonBackgroundView.dart';
import 'package:acuro/components/Common/CommonButton.dart';
import 'package:acuro/components/Common/CommonSplashBackView.dart';
import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/components/Login/CommonAuthHeader.dart';
import 'package:acuro/components/Login/OTPView.dart';
import 'package:acuro/core/constants/Constants.dart';
import 'package:acuro/core/navigator/AppRouter.gr.dart';
import 'package:acuro/core/persistence/PreferenceHelper.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:acuro/core/utils/TimeUtils.dart';
import 'package:acuro/models/Auth/OtpLimitationModel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class OtpVerifyPage extends StatefulWidget {
  final String phoneNumber;
  const OtpVerifyPage({super.key, required this.phoneNumber});

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  TextEditingController otpController = TextEditingController();
  bool hasError = false;
  String errorText = '';
  bool canResend = false;
  int timeLeft = 30;
  Timer? _timer;

  @override
  void initState() {
    startResendTimer();
    super.initState();
  }

  void startResendTimer() {
    _timer?.cancel();
    setState(() {
      canResend = false;
      timeLeft = 30;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
        setState(() {
          canResend = true;
        });
      }
    });
  }

  void resendCode() {
    if (canResend) {
      startResendTimer();
    }
  }

  void submitOtpFunc(AppLocalizations appText) {
    if (otpController.text != "123456") {
      setState(() {
        hasError = true;
        errorText = appText.code_you_have_entered_not_matched;
      });
    } else if (!hasError && otpController.text == "123456") {
      context.router.push(const EmailVerificationRoute());
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  static Future<void> setOtpValidation({
    required OTPLimitationModel otpLimitationModel,
  }) async {
    List<OTPLimitationModel> otpList =
        await PreferenceHelper.getOtpLimitation();
    int index = otpList.indexWhere(
      (element) =>
          element.emailOrPhoneName == otpLimitationModel.emailOrPhoneName &&
          element.otpFrom == otpLimitationModel.otpFrom,
    );
    if (index != -1) {
      otpList[index].limit += 1;
      otpList[index].time = DateTime.now().toIso8601String();
    } else {
      otpList.add(OTPLimitationModel(
        otpFrom: otpLimitationModel.otpFrom,
        emailOrPhoneName: otpLimitationModel.emailOrPhoneName,
        limit: 1,
        time: DateTime.now().toIso8601String(),
      ));
    }
    await PreferenceHelper.setOtpLimitation(otpUserList: otpList);
  }

  static Future<int> getOtpValidation(
      {required String emailOrPhoneName, required OTPEnum otpFrom}) async {
    List<OTPLimitationModel> otpList =
        await PreferenceHelper.getOtpLimitation();

    otpList.removeWhere((element) {
      DateTime elementTime = DateTime.parse(element.time);
      DateTime currentTime = DateTime.now();
      Duration difference = currentTime.difference(elementTime);
      return difference.inHours >= 8;
    });

    int index = otpList.indexWhere(
      (element) =>
          element.emailOrPhoneName == emailOrPhoneName &&
          element.otpFrom == otpFrom,
    );
    if(index != -1){
      return otpList[index].limit;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    var appText = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        AppUtils.closeTheKeyboard(context);
      },
      child: Scaffold(
        backgroundColor: ColorConstants.white1,
        body: CommonBackgroundView(
          child: Padding(
            padding: EdgeInsets.only(
                top: 60.h, bottom: 24.h, left: 20.w, right: 20.w),
            child: SmoothView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // back view
                  CommonBackView(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 14.h),
                  // headerView
                  headerView(appText),
                  SizedBox(height: 32.h),
                  // otp View
                  OtpView(
                    controller: otpController,
                    hasError: hasError,
                    onChanged: (p0) {
                      hasError = false;
                      setState(() {});
                    },
                  ),
                  // otp error view
                  errorView(),
                  SizedBox(height: 16.h),
                  //resend text
                  resendText(appText),
                  const Spacer(),
                  // submit button
                  CommonButton(
                      onTap: () {
                        submitOtpFunc(appText);
                      },
                      isEnable: otpController.text.length == 6,
                      buttonText: appText.continueText)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget headerView(AppLocalizations appText) {
    return CommonAuthHeader(
      headerText: appText.six_digit_code,
      bodyText:
          "${appText.please_enter_the_code_we_sent_to}\n${widget.phoneNumber}",
    );
  }

  Widget errorView() {
    return hasError
        ? Text(
            errorText,
            style: textWith16W400(ColorConstants.red),
          )
        : const SizedBox.shrink();
  }

  Widget resendText(AppLocalizations appText) {
    return canResend
        ? InkWell(
            onTap: () {
              resendCode();
            },
            child: Text(
              appText.resend_code,
              style: textWith16W500(ColorConstants.blue),
            ),
          )
        : Text(
            "${appText.resend_code_in}${TimeUtils.otpTime(timeLeft)}",
            style: textWith16W400(Theme.of(context).focusColor),
          );
  }
}
