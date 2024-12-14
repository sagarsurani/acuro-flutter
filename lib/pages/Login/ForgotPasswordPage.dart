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
import 'package:acuro/core/constants/EnvVariable.dart';
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
import '../../core/constants/Constants.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  int currentIndex = 0;
  String countryCode = '+91';
  String countryName = 'India';
  String countryFlag = 'IN';
  bool isLoading = false;
  String errorText = '';
  bool hasError = false;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: currentIndex,
    );
    super.initState();
  }

  void callApiForSentOtp() {
    getIt<AuthBloc>().add(
      SendOtpEvent(
          phoneNumber: "$countryCode${phoneController.text}",
          isFromForgot: true),
    );
  }

  void onTabChanged(int index) {
    setState(() {
      currentIndex = index;
      hasError = false;
    });
  }

  bool isButtonEnabled() {
    return currentIndex == 0
        ? AppUtils.isEmailValid(emailController.text.trim())
        : phoneController.text.trim().length == 10;
  }

  void navigateToOtpPage({required String verificationId}) {
    context.router.push(ForgotOtpRoute(
        isEmail: currentIndex == 0,
        verificationId: verificationId,
        detailsValue: currentIndex == 0
            ? emailController.text.trim()
            : "$countryCode ${phoneController.text}"));
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
        errorText = state.errorMessage;
      }
      if (state is AuthOtpSent) {
        isLoading = false;
        navigateToOtpPage(verificationId: state.verificationId);
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
                  Text(
                    appText.forgot_password,
                    textAlign: TextAlign.center,
                    style: textWith24W500(Theme.of(context).focusColor),
                  ),
                  SizedBox(height: 12.h),
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
                          callApiForSentOtp();
                        }
                      },
                      isEnable: isButtonEnabled(),
                      isLoading: isLoading,
                      buttonText: appText.sent_reset_code)
                  // button
                ],
              ),
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
            emailForgotView(appText),
            mobileForgotView(appText),
          ]),
    );
  }

  Widget emailForgotView(AppLocalizations appText) {
    return SmoothView(
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
          SizedBox(
            height: 12.h,
          ),
          errorView()
        ],
      ),
    );
  }

  Widget mobileForgotView(AppLocalizations appText) {
    return SmoothView(
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
                inputFormatters: AppUtils.onlyDigitsFormatter(max_number),
                onChanged: (p0) {
                  hasError = false;
                  setState(() {});
                },
              )),
              SizedBox(
                height: 12.h,
              ),
            ],
          ),
          SizedBox(height: 12.h,),
          errorView()
        ],
      ),
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
}
