import 'package:acuro/components/Common/CommonBackgroundView.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
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
  bool isPasswordVisible = false;
  bool isConformPasswordVisible = false;
  final pageController = PageController();
  int currentIndex = 0;
  bool hasError = false;
  List<String> errorsText = [];

  bool isNameValid() {
    if (!isNameContainsOnlyCharacters(firstNameController.text) ||
        !isNameContainsOnlyCharacters(lastNameController.text)) {
      return false;
    }
    return true;
  }

  bool isNameContainsOnlyCharacters(String text) {
    final RegExp characterRegex = RegExp(r'^[a-zA-Z]+$');
    return characterRegex.hasMatch(text);
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
        hasError = false;
        AppUtils.closeTheKeyboard(context);
        pageController.nextPage(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut);
      } else {
        hasError = true;
        errorsText = [
          appText.we_dont_allow_number,
          appText.we_dont_allow_special_characters_for_name,
        ];
        setState(() {});
      }
    }
  }

  void checkNameChangedValidation(String text) {
    var appText = AppLocalizations.of(context)!;
    if (text.isNotEmpty && !isNameContainsOnlyCharacters(text)) {
      hasError = true;
      errorsText = [
        appText.we_dont_allow_number,
        appText.we_dont_allow_special_characters_for_name,
      ];
    } else {
      hasError = false;
    }
    setState(() {});
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
        hasError = false;
        setState(() {});
      },
      child: GestureDetector(
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
            hasError: !isNameContainsOnlyCharacters(firstNameController.text)
                ? hasError
                : null,
            onChanged: (p0) {
              checkNameChangedValidation(firstNameController.text);
            },
          ),
          SizedBox(height: 10.h),
          CustomTextField(
            controller: lastNameController,
            hint: appText.last_name,
            hasError: !isNameContainsOnlyCharacters(lastNameController.text)
                ? hasError
                : null,
            keyboardType: TextInputType.name,
            onChanged: (p0) {
              checkNameChangedValidation(lastNameController.text);
            },
          ),
          SizedBox(height: 12.h),

          // error view
          errorView(appText),
          if (!hasError) const Spacer(),

          // submit details button
          CommonButton(
              onTap: tapOnUserDetailsSubmit,
              isEnable: isNameValid(),
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
          // error view
          errorView(appText),
          if (!hasError) const Spacer(),
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
        ? Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(height: 10.h);
            },
            padding: EdgeInsets.zero,
            shrinkWrap: true,
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
