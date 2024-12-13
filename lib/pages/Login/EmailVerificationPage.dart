import 'dart:async';
import 'package:acuro/components/Common/AnimatedSwitcher.dart';
import 'package:acuro/components/Common/CommonBackgroundView.dart';
import 'package:acuro/components/Common/CommonButton.dart';
import 'package:acuro/components/Common/CommonSplashBackView.dart';
import 'package:acuro/components/Common/CustomTextField.dart';
import 'package:acuro/components/Login/CommonAuthHeader.dart';
import 'package:acuro/components/Login/OTPView.dart';
import 'package:acuro/core/navigator/AppRouter.gr.dart';
import 'package:acuro/core/persistence/PreferenceHelper.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:acuro/core/utils/TimeUtils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../components/Common/CommonTextStyle.dart';

@RoutePage()
class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final emailController = TextEditingController();
  final pageController = PageController();
  final otpController = TextEditingController();
  int currentIndex = 0;
  bool hasError = false;
  bool canResend = false;
  int timeLeft = 30;
  Timer? _timer;

  @override
  void initState() {
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

  void submitEmailFunc() {
    if (AppUtils.isEmailValid(emailController.text.trim())) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      startResendTimer();
    }
  }

  void submitOtpFunc(AppLocalizations appText) {
    if (otpController.text != "123456") {
      setState(() {
        hasError = true;
      });
    } else if (!hasError && otpController.text == "123456") {
      context.router.push(const TakeUserDetailsRoute());
      setUserEmail();
    }
  }

  Future<void> setUserEmail() async {
    await PreferenceHelper.setUserEmail(emailController.text.trim());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
                top: currentIndex == 0 ? 90.h : 60.h,
                bottom: 24.h,
                left: 20.w,
                right: 20.w),
            child: SmoothView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // back view
                  if (currentIndex != 0)
                    CommonBackView(
                      onTap: () {
                        pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                        _timer?.cancel();
                        setState(() {});
                      },
                    ),
                  SizedBox(height: 14.h),
                  // content view
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (value) {
                        currentIndex = value;
                        setState(() {});
                      },
                      children: [
                        emailView(appText),
                        enterEmailOtpView(appText),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailView(AppLocalizations appText) {
    return SmoothView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 14.h),
          CommonAuthHeader(
              headerText: appText.what_is_your_email,
              bodyText: appText.enter_your_work_email),
          SizedBox(height: 32.h),
          // email text field
          CustomTextField(
            controller: emailController,
            hint: appText.work_email,
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            onChanged: (p0) {
              setState(() {});
            },
          ),
          const Spacer(),
          // email submit button
          CommonButton(
              onTap: submitEmailFunc,
              isEnable: AppUtils.isEmailValid(emailController.text.trim()),
              buttonText: appText.get_verification_code)
        ],
      ),
    );
  }

  Widget enterEmailOtpView(AppLocalizations appText) {
    return SmoothView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 14.h),
          CommonAuthHeader(
              headerText: appText.confirm_your_email,
              bodyText:
                  "${appText.please_enter_the_code_we_sent_to}\n${emailController.text.trim()}"),
          SizedBox(height: 32.h),
          // otp view
          OtpView(
            controller: otpController,
            hasError: hasError,
            onChanged: (p0) {
              hasError = false;
              setState(() {});
            },
          ),
          // otp error view
          errorView(appText),
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
    );
  }

  Widget errorView(AppLocalizations appText) {
    return hasError
        ? Text(
            appText.code_you_have_entered_not_matched,
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
