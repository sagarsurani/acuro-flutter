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
  String errorText = "";

  bool isBothPasswordMatched() {
    return passwordController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty &&
        AppUtils.isPasswordValid(passwordController.text.trim()) &&
        passwordController.text.trim() == confirmPasswordController.text.trim();
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
                    const Spacer(),
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
            style: textWith24W500(ColorConstants.black1),
          ),
          SizedBox(height: 32.h),

          // create password text field
          CustomTextField(
            controller: passwordController,
            hint: appText.enter_password,
            keyboardType: TextInputType.name,
            isPng: false,
            suffixIcon: isPasswordValid() ? ImageConstants.icRight : null,
            fontStyle: passwordController.text.trim().isNotEmpty
                ? textWith20W500(ColorConstants.black1)
                : textWith20W400(ColorConstants.black1),
            isObscureText: true,
            onChanged: (p0) {
              setState(() {});
            },
          ),
          SizedBox(height: 10.h),
          CustomTextField(
            controller: confirmPasswordController,
            hint: appText.enter_confirm_password,
            keyboardType: TextInputType.name,
            isPng: false,
            isObscureText: true,
            fontStyle: confirmPasswordController.text.trim().isNotEmpty
                ? textWith20W500(ColorConstants.black1)
                : textWith20W400(ColorConstants.black1),
            onChanged: (p0) {
              setState(() {});
            },
            suffixIcon: isBothPasswordMatched()
                ? ImageConstants.icRight
                : confirmPasswordController.text.trim().isNotEmpty
                    ? ImageConstants.icWrong
                    : null,
          ),

          // error view
          errorView(appText),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget errorView(AppLocalizations appText) {
    return hasError
        ? Text(
            errorText,
            style: textWith16W400(ColorConstants.red),
          )
        : const SizedBox.shrink();
  }
}
