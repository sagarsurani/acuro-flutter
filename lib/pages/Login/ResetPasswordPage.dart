import 'package:acuro/application/application/auth/bloc/AuthEvent.dart';
import 'package:acuro/application/application/auth/bloc/AuthState.dart';
import 'package:acuro/components/Common/AnimatedSwitcher.dart';
import 'package:acuro/components/Common/CommonBackgroundView.dart';
import 'package:acuro/components/Common/CommonButton.dart';
import 'package:acuro/components/Common/CommonErrorWidget.dart';
import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/components/Common/CustomTextField.dart';
import 'package:acuro/core/constants/ImageConstants.dart';
import 'package:acuro/core/di/Injectable.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../application/application/auth/bloc/AuthBloc.dart';

@RoutePage()
class ResetPasswordPage extends StatefulWidget {
  final String emailOrPhone;
  final bool isPhone;
  const ResetPasswordPage(
      {super.key, required this.emailOrPhone, required this.isPhone});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool hasError = false;
  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConformPasswordVisible = false;
  final pageController = PageController();
  int currentIndex = 0;
  List<String> errorsText = [];

  bool isBothPasswordMatched() {
    return passwordController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty &&
        AppUtils.isPasswordValid(passwordController.text.trim()) &&
        passwordController.text.trim() == confirmPasswordController.text.trim();
  }

  void callResetPasswordApi() {
    getIt<AuthBloc>().add(ResetPassword(
        emailOrPhone: widget.emailOrPhone,
        password: passwordController.text.trim(),
        isPhone: widget.isPhone));
  }

  void checkPasswordChangedValidation(String text) {
    var appText = AppLocalizations.of(context)!;
    if (text.isNotEmpty && !AppUtils.isPasswordValid(text)) {
      hasError = true;
      errorsText = [
        appText.minimum_length_should_be_eight,
        appText.contains_at_least_one_number,
        appText.contains_at_least_one_special_character,
        appText.contains_at_least_one_uppercase_letter
      ];
    } else if (confirmPasswordController.text.trim().isNotEmpty &&
        !isBothPasswordMatched()) {
      hasError = true;
      errorsText = [
        appText.password_not_matched,
      ];
    } else {
      hasError = false;
    }
    setState(() {});
  }

  bool isPasswordValid() {
    return AppUtils.isPasswordValid(passwordController.text.trim());
  }

  void tapOnSubmitPassword() {
    if (isBothPasswordMatched()) {
      callResetPasswordApi();
    }
  }

  @override
  Widget build(BuildContext context) {
    var appText = AppLocalizations.of(context)!;
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is ResetAuthLoading) {
        isLoading = true;
      }
      if (state is ResetPasswordError) {
        isLoading = false;
        hasError = true;
        errorsText = [
          state.errorMessage,
        ];
      }
      if (state is ResetPasswordDone) {
        isLoading = false;
        context.router.popUntil((route) => route.isFirst);
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: ColorConstants.white1,
        body: GestureDetector(
          onTap: () {
            AppUtils.closeTheKeyboard(context);
          },
          child: Scaffold(
            body: CommonBackgroundView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 90.h, bottom: 24.h, left: 20.w, right: 20.w),
                child: SmoothView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // content view
                      resetYourPasswordView(appText),
                      // error view
                      errorView(appText),
                      SizedBox(height: 16.h),
                      const Spacer(),
                      // submit button
                      CommonButton(
                          onTap: tapOnSubmitPassword,
                          isLoading: isLoading,
                          isEnable: isBothPasswordMatched(),
                          buttonText: appText.reset_password)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget resetYourPasswordView(AppLocalizations appText) {
    return SmoothView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // content view
          Text(
            appText.update_your_password,
            textAlign: TextAlign.center,
            style: textWith24W500(Theme.of(context).focusColor),
          ),
          SizedBox(height: 32.h),

          // create password text field
          CustomTextField(
            controller: passwordController,
            hint: appText.enter_password,
            keyboardType: TextInputType.name,
            isPng: false,
            onTapOnIcon: () {
              isPasswordVisible = !isPasswordVisible;
              setState(() {});
            },
            isObscureText: !isPasswordVisible ? true : false,
            suffixIcon: !isPasswordVisible
                ? ImageConstants.icEyesClosed
                : ImageConstants.icEyeOpened,
            fontStyle:
                passwordController.text.trim().isNotEmpty && !isPasswordVisible
                    ? textWith20W500(Theme.of(context).focusColor)
                    : textWith20W400(Theme.of(context).focusColor),
            onChanged: (p0) {
              checkPasswordChangedValidation(passwordController.text);
            },
          ),
          SizedBox(height: 10.h),
          CustomTextField(
            controller: confirmPasswordController,
            hint: appText.enter_confirm_password,
            keyboardType: TextInputType.name,
            isPng: false,
            onTapOnIcon: () {
              isConformPasswordVisible = !isConformPasswordVisible;
              setState(() {});
            },
            isObscureText: !isConformPasswordVisible ? true : false,
            suffixIcon: !isConformPasswordVisible
                ? ImageConstants.icEyesClosed
                : ImageConstants.icEyeOpened,
            fontStyle: confirmPasswordController.text.trim().isNotEmpty &&
                    !isConformPasswordVisible
                ? textWith20W500(Theme.of(context).focusColor)
                : textWith20W400(Theme.of(context).focusColor),
            onChanged: (p0) {
              checkPasswordChangedValidation(confirmPasswordController.text);
            },
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  Widget errorView(AppLocalizations appText) {
    return hasError
        ? CommonErrorWidget(
            errors: errorsText,
          )
        : const SizedBox.shrink();
  }
}
