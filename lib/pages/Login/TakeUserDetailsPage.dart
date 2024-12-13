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

  void tapOnUserDetailsSubmit() {
    var appText = AppLocalizations.of(context)!;
    if (checkUserDetailsValidation()) {
      if (isNameValid()) {
        hasError = false;
        AppUtils.closeTheKeyboard(context);
        context.router.push(const CreatePasswordRoute());
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

  @override
  Widget build(BuildContext context) {
    var appText = AppLocalizations.of(context)!;
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () {
          AppUtils.closeTheKeyboard(context);
        },
        child: Scaffold(
          backgroundColor: ColorConstants.white1,
          body: CommonBackgroundView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 90.h, bottom: 24.h, left: 20.w, right: 20.w),
                        child: firstAndLastNameView(appText),
                      ),
                    ),
                  ),
                  // submit details button
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 24.h, horizontal: 20.w),
                    child: CommonButton(
                        onTap: tapOnUserDetailsSubmit,
                        isEnable: isNameValid(),
                        buttonText: appText.continueText),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget firstAndLastNameView(AppLocalizations appText) {
    return Column(
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

      ],
    );
  }

  Widget errorView(AppLocalizations appText) {
    return hasError
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: errorsText.map((error) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(ImageConstants.icRedClose),
              SizedBox(width: 2.w),
              Text(
                error,
                style: textWith14W400(ColorConstants.red),
              ),
            ],
          ),
        );
      }).toList(),
    )
        : const SizedBox.shrink();
  }
}
