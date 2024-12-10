import 'package:acuro/components/Common/CommonSplashBackView.dart';
import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/components/Common/CustomTextField.dart';
import 'package:acuro/components/Login/CommonAuthHeader.dart';
import 'package:acuro/core/constants/ImageConstants.dart';
import 'package:acuro/core/navigator/AppRouter.gr.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/Common/AnimatedSwitcher.dart';
import '../../components/Common/CommonButton.dart';

@RoutePage()
class TakeUserDetailsPage extends StatefulWidget {
  const TakeUserDetailsPage({super.key});

  @override
  State<TakeUserDetailsPage> createState() => _TakeUserDetailsPageState();
}

class _TakeUserDetailsPageState extends State<TakeUserDetailsPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final pageController = PageController();
  int currentIndex = 0;
  bool hasError = false;
  String errorText = "";

  bool isNameValid() {
    if (isNameContainsOnlyNumbers(firstNameController.text.trim()) ||
        isNameContainsOnlyNumbers(lastNameController.text.trim())) {
      return false;
    }
    return true;
  }

  bool isNameContainsOnlyNumbers(String text) {
    final RegExp numberRegex = RegExp(r'^[0-9]+$');
    return numberRegex.hasMatch(text.replaceAll(' ', ''));
  }

  bool checkUserDetailsValidation() {
    return firstNameController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty;
  }

  bool isPasswordValid() {
    return AppUtils.isPasswordValid(passwordController.text.trim());
  }

  bool isBothPasswordMatched() {
    return passwordController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty &&
        AppUtils.isPasswordValid(passwordController.text.trim()) &&
        passwordController.text.trim() == confirmPasswordController.text.trim();
  }

  void tapOnUserDetailsSubmit() {
    var appText = AppLocalizations.of(context)!;
    if (checkUserDetailsValidation()) {
      if (isNameValid()) {
        AppUtils.closeTheKeyboard(context);
        pageController.nextPage(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut);
      } else {
        hasError = true;
        errorText = appText.we_dont_allow_number;
        setState(() {});
      }
    }
  }

  void tapOnSubmitPassword() {
    if (isBothPasswordMatched()) {
      context.router.push(const SelectRoleRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    var appText = AppLocalizations.of(context)!;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
        currentIndex = pageController.page?.toInt() ?? 0;
      },
      child: GestureDetector(
        onTap: () {
          AppUtils.closeTheKeyboard(context);
        },
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
                top: currentIndex == 0 ? 90.h : 60.h,
                bottom: 24.h,
                left: 20.w,
                right: 20.w),
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
                      firstAndLastNameView(appText),
                      setYourPasswordView(appText),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget firstAndLastNameView(AppLocalizations appText) {
    return SmoothView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 14.h),
          CommonAuthHeader(
              headerText: appText.whats_your_name,
              bodyText: appText.enter_your_first_and_last_name),
          SizedBox(height: 32.h),

          // name text field
          CustomTextField(
            controller: firstNameController,
            hint: appText.first_name,
            keyboardType: TextInputType.name,
            onChanged: (p0) {
              hasError = false;
              setState(() {});
            },
          ),
          SizedBox(height: 10.h),
          CustomTextField(
            controller: lastNameController,
            hint: appText.last_name,
            keyboardType: TextInputType.name,
            onChanged: (p0) {
              hasError = false;
              setState(() {});
            },
          ),
          SizedBox(height: 12.h),

          // error view
          errorView(appText),
          SizedBox(height: 16.h),
          const Spacer(),

          // submit details button
          CommonButton(
              onTap: tapOnUserDetailsSubmit,
              isEnable: checkUserDetailsValidation(),
              buttonText: appText.continueText)
        ],
      ),
    );
  }

  Widget setYourPasswordView(AppLocalizations appText) {
    return SmoothView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 14.h),
          CommonAuthHeader(
              headerText: appText.create_password,
              bodyText: appText.please_set_your_password_and_confirm_password),
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
          const Spacer(),

          // submit button
          CommonButton(
              onTap: tapOnSubmitPassword,
              isEnable: isBothPasswordMatched(),
              buttonText: appText.continueText)
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
