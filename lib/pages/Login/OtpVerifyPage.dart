import 'dart:async';
import 'package:acuro/application/application/auth/bloc/AuthBloc.dart';
import 'package:acuro/application/application/auth/bloc/AuthEvent.dart';
import 'package:acuro/application/application/auth/bloc/AuthState.dart';
import 'package:acuro/components/Common/AnimatedSwitcher.dart';
import 'package:acuro/components/Common/CommonBackgroundView.dart';
import 'package:acuro/components/Common/CommonButton.dart';
import 'package:acuro/components/Common/CommonSplashBackView.dart';
import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/components/Login/CommonAuthHeader.dart';
import 'package:acuro/components/Login/OTPView.dart';
import 'package:acuro/core/constants/Constants.dart';
import 'package:acuro/core/di/Injectable.dart';
import 'package:acuro/core/navigator/AppRouter.gr.dart';
import 'package:acuro/core/persistence/PreferenceHelper.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:acuro/core/utils/TimeUtils.dart';
import 'package:acuro/models/Auth/OtpLimitationModel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class OtpVerifyPage extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  const OtpVerifyPage(
      {super.key, required this.phoneNumber, required this.verificationId});

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  TextEditingController otpController = TextEditingController();
  bool hasError = false;
  bool isLoading = false;
  String errorText = '';
  bool canResend = false;
  String verificationId = "";
  int timeLeft = 60;
  int resendOtpValidation = 0;
  Timer? _timer;

  @override
  void initState() {
    verificationId = widget.verificationId;
    startResendTimer();
    super.initState();
  }

  void callApiForSentOtp() {
    getIt<AuthBloc>().add(VerifyOtpEvent(
        smsCode: otpController.text.trim(), verificationId: verificationId));
  }

  void callApiForResendOtp() {
    getIt<AuthBloc>().add(
        ResendOtpEvent(phoneNumber: widget.phoneNumber, isFromForgot: false));
  }

  void startResendTimer() {
    _timer?.cancel();
    setState(() {
      canResend = false;
      timeLeft = 60;
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
      callApiForResendOtp();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appText = AppLocalizations.of(context)!;
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthVerifyLoading) {
        isLoading = true;
      }
      if (state is AuthVerifyError) {
        isLoading = false;
        if (!state.errorMessage.contains(BLOCKED)) {
          hasError = true;
          errorText = appText.code_you_have_entered_not_matched;
        } else if (state.errorMessage == SO_MANY_ATTEMPT) {
          _timer?.cancel();
          canResend = resendOtpValidation > 5;
        }
      }
      if (state is ResendOtpSend) {
        isLoading = false;
        verificationId = state.verificationId;
      }
      if (state is AuthVerified) {
        isLoading = false;
        context.router.push(const EmailVerificationRoute());
      }
    }, builder: (context, state) {
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
                        onTap: callApiForSentOtp,
                        isLoading: isLoading,
                        isEnable: otpController.text.length == 6,
                        buttonText: appText.continueText)
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
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
    return resendOtpValidation > 5
        ? Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 5.w),
            decoration: BoxDecoration(
              color: ColorConstants.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(width: 1.w, color: ColorConstants.red),
            ),
            child: Text(
              appText.exceed_the_attempts_try_again_after_eight_hour,
              textAlign: TextAlign.center,
              style: textWith14W500(Theme.of(context).focusColor),
            ),
          )
        : canResend
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
