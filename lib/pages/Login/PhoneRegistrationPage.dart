import 'package:acuro/application/application/auth/bloc/AuthBloc.dart';
import 'package:acuro/application/application/auth/bloc/AuthEvent.dart';
import 'package:acuro/application/application/auth/bloc/AuthState.dart';
import 'package:acuro/components/Common/AnimatedSwitcher.dart';
import 'package:acuro/components/Common/CommonBackgroundView.dart';
import 'package:acuro/components/Common/CommonButton.dart';
import 'package:acuro/components/Common/CommonSplashBackView.dart';
import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/components/Common/CountryCodePicker.dart';
import 'package:acuro/components/Common/CustomTextField.dart';
import 'package:acuro/components/Login/CommonAuthHeader.dart';
import 'package:acuro/core/constants/EnvVariable.dart';
import 'package:acuro/core/di/Injectable.dart';
import 'package:acuro/core/navigator/AppRouter.gr.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class PhoneRegistrationPage extends StatefulWidget {
  const PhoneRegistrationPage({super.key});

  @override
  State<PhoneRegistrationPage> createState() => _PhoneRegistrationPageState();
}

class _PhoneRegistrationPageState extends State<PhoneRegistrationPage> {
  TextEditingController phoneController = TextEditingController();
  String countryCode = '+91';
  String countryName = 'India';
  String countryFlag = 'IN';
  bool isButtonEnabled = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      validatePhoneNumber(phoneController.text);
    });
  }

  void callApiForSentOtp() {
    getIt<AuthBloc>().add(SendOtpEvent(
        phoneNumber: "$countryCode${phoneController.text}",
        isFromForgot: false));
  }

  void validatePhoneNumber(String value) {
    setState(() {
      isButtonEnabled = value.length == 10;
    });
  }

  void navigateToOtpPage(String verificationId) {
    context.pushRoute(OtpVerifyRoute(
        phoneNumber: "$countryCode ${phoneController.text}",
        verificationId: verificationId));
  }

  void navigateToLoginRoute() {
    context.router.push(const LoginRoute());
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
      }
      if (state is AuthOtpSent) {
        isLoading = false;
        navigateToOtpPage(state.verificationId);
      }
    }, builder: (context, state) {
      return GestureDetector(
        onTap: () {
          AppUtils.closeTheKeyboard(context);
        },
        child: Scaffold(
          body: CommonBackgroundView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 60.h, bottom: 24.h, left: 20.w, right: 20.w),
              child: SmoothView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonBackView(
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 14.h),
                    headerView(appText),
                    SizedBox(height: 32.h),
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
                              phoneController.clear();
                            });
                          },
                        ),
                        SizedBox(width: 8.w),
                        // Phone text field
                        Expanded(
                            child: CustomTextField(
                          hint: appText.mobile_number,
                          controller: phoneController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          inputFormatters:
                              AppUtils.onlyDigitsFormatter(max_number),
                        ))
                      ],
                    ),
                    SizedBox(height: 16.h),
                    InkWell(
                      onTap: navigateToLoginRoute,
                      child: Text(
                        appText.already_have_an_account,
                        style: textWith16W500(ColorConstants.blue),
                      ),
                    ),
                    const Spacer(),
                    // get otp button
                    CommonButton(
                        onTap: () {
                          if (isButtonEnabled) {
                            callApiForSentOtp();
                          }
                        },
                        isEnable: isButtonEnabled,
                        isLoading: isLoading,
                        buttonText: appText.get_otp)
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
      headerText: appText.what_is_your_phone_number,
      bodyText: appText.enter_your_phone_number_desc,
    );
  }
}
