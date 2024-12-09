import 'package:acuro/components/Common/CommonButton.dart';
import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/core/constants/ImageConstants.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class OtpVerifyPage extends StatefulWidget {
  const OtpVerifyPage({super.key});

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  @override
  Widget build(BuildContext context) {
    var appText = AppLocalizations.of(context)!;
    return Scaffold(
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
              appText.six_digit_code,
              style: textWith24W500(ColorConstants.black1),
            ),
            SizedBox(height: 4.h),
            Text(
              appText.please_enter_the_code_we_sent_to,
              style: textWith14W400(ColorConstants.grey1),
            ),
            SizedBox(height: 32.h),
            OtpTextField(
              fieldWidth: MediaQuery.of(context).size.width / 5.15,
              filled: true,
              fillColor: ColorConstants.grey2,
              numberOfFields: 4,
              cursorColor: Colors.transparent,
              textStyle: textWith20W400(ColorConstants.black1),
              borderRadius: BorderRadius.circular(10),
              showFieldAsBox: true,
            ),
            SizedBox(height: 16.h),
            Text(
              appText.already_have_an_account,
              style: textWith16W500(ColorConstants.blue),
            ),
            const Spacer(),
            CommonButton(onTap: () {}, buttonText: appText.get_otp)
          ],
        ),
      ),
    );
  }
}
