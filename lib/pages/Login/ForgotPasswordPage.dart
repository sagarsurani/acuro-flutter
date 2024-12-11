import 'package:acuro/components/Common/AnimatedSwitcher.dart';
import 'package:acuro/components/Common/CommonBackgroundView.dart';
import 'package:acuro/components/Common/CommonButton.dart';
import 'package:acuro/components/Common/CommonSplashBackView.dart';
import 'package:acuro/components/Common/CommonTabView.dart';
import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/components/Common/CountryCodePicker.dart';
import 'package:acuro/components/Common/CustomTextField.dart';
import 'package:acuro/core/navigator/AppRouter.gr.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: currentIndex,
    );
    super.initState();
  }

  void onTabChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  bool isButtonEnabled() {
    return currentIndex == 0
        ? AppUtils.isEmailValid(emailController.text.trim())
        : phoneController.text.trim().length == 10;
  }

  void navigateToOtpRoute() {
    context.router.push(ForgotOtpRoute(
        isEmail: currentIndex == 0,
        detailsValue: currentIndex == 0
            ? emailController.text.trim()
            : "$countryCode ${phoneController.text}"));
  }

  @override
  Widget build(BuildContext context) {
    var appText = AppLocalizations.of(context)!;
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
                  style: textWith24W500(ColorConstants.black1),
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
                        navigateToOtpRoute();
                      }
                    },
                    isEnable: isButtonEnabled(),
                    buttonText: appText.sent_reset_code)
                // button
              ],
            ),
          ),
        ),
      ),
    );
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
              setState(() {});
            },
          ),
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
                backgroundColor: ColorConstants.countryBackground,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: AppUtils.onlyDigitsFormatter(maxPhoneLength),
                onChanged: (p0) {
                  setState(() {});
                },
              ))
            ],
          ),
        ],
      ),
    );
  }
}
