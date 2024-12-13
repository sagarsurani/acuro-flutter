import 'package:acuro/application/application/auth/bloc/AuthBloc.dart';
import 'package:acuro/application/application/auth/bloc/AuthEvent.dart';
import 'package:acuro/application/application/auth/bloc/AuthState.dart';
import 'package:acuro/components/Common/AnimatedSwitcher.dart';
import 'package:acuro/components/Common/CommonBackgroundView.dart';
import 'package:acuro/components/Common/CommonButton.dart';
import 'package:acuro/components/Common/CommonErrorWidget.dart';
import 'package:acuro/components/Common/CommonSplashBackView.dart';
import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/components/Common/CustomTextField.dart';
import 'package:acuro/components/Login/CommonAuthHeader.dart';
import 'package:acuro/core/constants/Constants.dart';
import 'package:acuro/core/constants/ImageConstants.dart';
import 'package:acuro/core/di/Injectable.dart';
import 'package:acuro/core/navigator/AppRouter.gr.dart';
import 'package:acuro/core/persistence/PreferenceHelper.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:acuro/models/Auth/UserModel.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class CreatePasswordPage extends StatefulWidget {
  final String firstName;
  final String lastName;
  const CreatePasswordPage(
      {super.key, required this.firstName, required this.lastName});

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConformPasswordVisible = false;
  bool hasError = false;
  bool isLoading = false;
  String emailId = "";
  List<String> errorsText = [];

  @override
  void initState() {
    getUserEmail();
    super.initState();
  }

  Future<void> getUserEmail() async {
    String? email = await PreferenceHelper.getUserEmail();
    emailId = email ?? "";
    setState(() {});
  }

  void callApiForLoginWithEmail() {
    getIt<AuthBloc>().add(EmailAuthSignUpEvent(
        email: emailId,
        password: passwordController.text.trim(),
        userData: UserModel(
          email: emailId,
          firstName: widget.firstName,
          lastName: widget.lastName,
        )));
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
      callApiForLoginWithEmail();
    }
  }

  @override
  Widget build(BuildContext context) {
    var appText = AppLocalizations.of(context)!;
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthLoading) {
        isLoading = true;
      }
      if (state is AuthError) {
        isLoading = false;
        hasError = true;
        errorsText = [
          state.errorMessage,
        ];
      }
      if (state is EmailAuthDone) {
        isLoading = false;
        hasError = false;
        context.router.replaceAll([const SelectRoleRoute()]);
      }
    }, builder: (context, state) {
      return GestureDetector(
        onTap: () {
          AppUtils.closeTheKeyboard(context);
        },
        child: Scaffold(
          body: CommonBackgroundView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
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
                              // content view
                              setYourPasswordView(appText),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // submit button
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
                    child: CommonButton(
                        onTap: tapOnSubmitPassword,
                        isEnable: isBothPasswordMatched(),
                        isLoading: isLoading,
                        buttonText: appText.continueText),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
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
          // if (!hasError) const Spacer(),
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
