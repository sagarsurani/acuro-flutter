import 'package:acuro/components/Common/AnimatedSwitcher.dart';
import 'package:acuro/components/Common/CommonBackgroundView.dart';
import 'package:acuro/components/Common/CommonButton.dart';
import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/components/Common/CustomTextField.dart';
import 'package:acuro/core/constants/ImageConstants.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool hasError = false;
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
    if (isBothPasswordMatched()) {}
  }

  @override
  Widget build(BuildContext context) {
    var appText = AppLocalizations.of(context)!;
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
                    if (!hasError) const Spacer(),
                    // submit button
                    CommonButton(
                        onTap: tapOnSubmitPassword,
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
        ? Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: 5.h);
              },
              padding: EdgeInsets.zero,
              itemCount: errorsText.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageConstants.icRedClose),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      errorsText[index],
                      style: textWith14W400(ColorConstants.red),
                    ),
                  ],
                );
              },
            ),
          )
        : const SizedBox.shrink();
  }
}
