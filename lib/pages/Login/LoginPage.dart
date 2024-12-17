import 'package:acuro/application/application/auth/bloc/AuthBloc.dart';
import 'package:acuro/application/application/auth/bloc/AuthEvent.dart';
import 'package:acuro/application/application/auth/bloc/AuthState.dart';
import 'package:acuro/components/Common/AnimatedSwitcher.dart';
import 'package:acuro/components/Common/CommonBackgroundView.dart';
import 'package:acuro/components/Common/CommonButton.dart';
import 'package:acuro/components/Common/CommonSplashBackView.dart';
import 'package:acuro/components/Common/CommonTabView.dart';
import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/components/Common/CountryCodePicker.dart';
import 'package:acuro/components/Common/CustomTextField.dart';
import 'package:acuro/components/Common/ErrorView.dart';
import 'package:acuro/core/constants/Constants.dart';
import 'package:acuro/core/constants/EnvVariable.dart';
import 'package:acuro/core/constants/ImageConstants.dart';
import 'package:acuro/core/di/Injectable.dart';
import 'package:acuro/core/navigator/AppRouter.gr.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentIndex = 0;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobilePasswordController = TextEditingController();
  final phoneController = TextEditingController();
  String countryCode = '+91';
  String countryName = 'India';
  String countryFlag = 'IN';
  bool hasError = false;
  String errorText = "";
  bool isLoading = false;
  bool isPhonePasswordVisible = false;
  bool isEmailConformPasswordVisible = false;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: currentIndex,
    );
    super.initState();
  }

  void callApiForLogin() {
    getIt<AuthBloc>().add(LoginAuthEvent(
        emailOrPhone: currentIndex == 1
            ? "$countryCode${phoneController.text.trim()}"
            : emailController.text.trim(),
        loginType: currentIndex == 1
            ? LoginType.signInWithPhone
            : LoginType.signInWithEmail,
        password: currentIndex == 1
            ? mobilePasswordController.text.trim()
            : passwordController.text.trim()));
  }

  void onTabChanged(int index) {
    setState(() {
      currentIndex = index;
      errorText = "";
      AppUtils.closeTheKeyboard(context);
    });
  }

  bool isButtonEnabled() {
    return currentIndex == 0
        ? AppUtils.isEmailValid(emailController.text.trim()) &&
            AppUtils.isPasswordValid(passwordController.text.trim())
        : phoneController.text.trim().length == EnvVariable.maxNumber &&
            AppUtils.isPasswordValid(mobilePasswordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    var appText = AppLocalizations.of(context)!;
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is LoginAuthLoading) {
        isLoading = true;
      }
      if (state is LoginAuthError) {
        isLoading = false;
        hasError = true;
        errorText = state.errorMessage;
      }
      if (state is LoginAuthDone) {
        isLoading = false;
        hasError = false;
        context.router.push(const MainRoute());
      }
    }, builder: (context, state) {
      return GestureDetector(
        onTap: () {
          AppUtils.closeTheKeyboard(context);
        },
        child: CommonBackgroundView(
          child: Padding(
            padding: EdgeInsets.only(
                top: 60.h, bottom: 24.h, left: 20.w, right: 20.w),
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

                Text(
                  appText.log_in,
                  textAlign: TextAlign.center,
                  style: textWith24W500(Theme.of(context).focusColor),
                ),
                SizedBox(height: 12.h),

                // tab bar view
                CommonTabHeaderView(
                    tabsList: tabsList,
                    controller: tabController,
                    currentIndex: currentIndex,
                    onTabChanged: onTabChanged),
                SizedBox(height: 24.h),

                // content view
                contentView(),

                // button
                CommonButton(
                    onTap: () {
                      if (isButtonEnabled()) {
                        callApiForLogin();
                      }
                    },
                    isEnable: isButtonEnabled(),
                    isLoading: isLoading,
                    buttonText: appText.log_in)
                // button
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget contentView() {
    var appText = AppLocalizations.of(context)!;
    return Expanded(
      child: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            emailLoginView(appText),
            mobileLoginView(appText),
          ]),
    );
  }

  Widget emailLoginView(AppLocalizations appText) {
    return SmootherView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: emailController,
            hint: appText.email,
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            onChanged: (p0) {
              hasError = false;
              setState(() {});
            },
          ),
          SizedBox(height: 12.h),
          CustomTextField(
            controller: passwordController,
            hint: appText.password,
            keyboardType: TextInputType.text,
            onTapOnIcon: () {
              isPhonePasswordVisible = !isPhonePasswordVisible;
              setState(() {});
            },
            isObscureText: !isPhonePasswordVisible ? true : false,
            suffixIcon: !isPhonePasswordVisible
                ? ImageConstants.icEyesClosed
                : ImageConstants.icEyeOpened,
            fontStyle: passwordController.text.trim().isNotEmpty &&
                    !isPhonePasswordVisible
                ? textWith20W500(Theme.of(context).focusColor)
                : textWith20W400(Theme.of(context).focusColor),
            onChanged: (p0) {
              hasError = false;
              setState(() {});
            },
          ),
          SizedBox(height: 12.h),
          forgotPasswordWidget(appText),
          SizedBox(height: 12.h),
          AuthErrorView(isError: hasError, errorText: errorText)
        ],
      ),
    );
  }

  Widget mobileLoginView(AppLocalizations appText) {
    return SmootherView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // country code pick view
              CountryCodePicker(
                countryCode: countryCode,
                countryFlag: countryFlag,
                countryName: countryName,
                onSelect: (country) {
                  setState(() {
                    countryCode = '+${country.phoneCode}';
                    countryName = country.name;
                    countryFlag = country.countryCode;
                  });
                },
              ),
              SizedBox(width: 8.w),
              // Phone text field
              Expanded(
                  child: CustomTextField(
                hint: appText.mobile_number,
                controller: phoneController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters:
                    AppUtils.onlyDigitsFormatter(EnvVariable.maxNumber),
                onChanged: (p0) {
                  hasError = false;
                  if (p0.trim().length == EnvVariable.maxNumber) {
                    AppUtils.closeTheKeyboard(context);
                  }
                  setState(() {});
                },
              ))
            ],
          ),
          SizedBox(height: 12.h),
          CustomTextField(
            controller: mobilePasswordController,
            hint: appText.password,
            keyboardType: TextInputType.text,
            onTapOnIcon: () {
              isEmailConformPasswordVisible = !isEmailConformPasswordVisible;
              setState(() {});
            },
            isObscureText: !isEmailConformPasswordVisible ? true : false,
            suffixIcon: !isEmailConformPasswordVisible
                ? ImageConstants.icEyesClosed
                : ImageConstants.icEyeOpened,
            fontStyle: mobilePasswordController.text.trim().isNotEmpty &&
                    !isEmailConformPasswordVisible
                ? textWith20W500(Theme.of(context).focusColor)
                : textWith20W400(Theme.of(context).focusColor),
            onChanged: (p0) {
              hasError = false;
              setState(() {});
            },
          ),

          // forgot password widget
          SizedBox(height: 12.h),
          forgotPasswordWidget(appText),

          // error widget
          SizedBox(height: 12.h),
          AuthErrorView(isError: hasError, errorText: errorText)
        ],
      ),
    );
  }

  Widget forgotPasswordWidget(AppLocalizations appText) {
    return InkWell(
      onTap: () {
        context.router.push(const ForgotPasswordRoute());
      },
      child: Text(appText.forgot_password,
          style: textWith16W500(ColorConstants.blue)),
    );
  }
}
