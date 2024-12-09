import 'package:acuro/components/Common/CommonButton.dart';
import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/components/Common/CustomTextField.dart';
import 'package:acuro/core/constants/ImageConstants.dart';
import 'package:acuro/core/navigator/AppRouter.gr.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      validatePhoneNumber(phoneController.text);
    });
  }

  void validatePhoneNumber(String value) {
    if (countryCode == '+91') {
      setState(() {
        isButtonEnabled = value.length == 10;
      });
    } else {
      setState(() {
        isButtonEnabled = value.length >= 6;
      });
    }
  }

  void navigateToOtpPage() {
    context.pushRoute(const OtpVerifyRoute());
  }

  @override
  Widget build(BuildContext context) {
    var appText = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        AppUtils.closeTheKeyboard(context);
      },
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.only(top: 60.h, bottom: 24.h, left: 20.w, right: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(ImageConstants.icArrowLeft),
              SizedBox(height: 14.h),
              Text(
                appText.what_is_your_phone_number,
                style: textWith24W500(ColorConstants.black1),
              ),
              SizedBox(height: 4.h),
              Text(
                appText.enter_your_phone_number_desc,
                style: textWith14W400(ColorConstants.grey1),
              ),
              SizedBox(height: 32.h),
              Row(
                children: [
                  countryCodePicker(),
                  SizedBox(width: 8.w),
                  Expanded(
                      child: CustomTextField(
                          hint: appText.mobile_number,
                          controller: phoneController))
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                appText.already_have_an_account,
                style: textWith16W500(ColorConstants.blue),
              ),
              const Spacer(),
              Opacity(
                  opacity: isButtonEnabled ? 1 : 0.5,
                  child: CommonButton(onTap: () {
                    if (isButtonEnabled) {
                      navigateToOtpPage();
                    }
                  }, buttonText: appText.get_otp))
            ],
          ),
        ),
      ),
    );
  }

  Widget countryCodePicker() {
    return InkWell(
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: true,
          onSelect: (Country country) {
            setState(() {
              countryCode = '+${country.phoneCode}';
              countryName = country.name;
              countryFlag = country.countryCode;
            });
          },
        );
      },
      child: Container(
        height: 61.h,
        width: 73.w,
        decoration: BoxDecoration(
          color: ColorConstants.countryBackground,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(countryFlag.toUpperCase().replaceAllMapped(
                  RegExp(r'[A-Z]'),
                  (match) => String.fromCharCode(
                    match.group(0)!.codeUnitAt(0) + 127397,
                  ),
                )),
            SizedBox(width: 4.w),
            Text(
              countryCode,
              style: textWith14W500(ColorConstants.black1),
            ),
          ],
        ),
      ),
    );
  }
}