import 'package:acuro/core/theme/AppColors.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class CountryCodePicker extends StatelessWidget {
  final String countryCode;
  final String countryName;
  final String countryFlag;
  final Function(Country) onSelect;

  const CountryCodePicker({
    super.key,
    required this.countryCode,
    required this.countryName,
    required this.countryFlag,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppUtils.closeTheKeyboard(context);
        showCountryPicker(
          context: context,
          showPhoneCode: true,
          onSelect: onSelect,
          countryListTheme: CountryListThemeData(
            bottomSheetHeight: MediaQuery.of(context).size.height * 0.75,
            searchTextStyle: const TextStyle(
              color: ColorConstants.blue,
            ),
            textStyle: const TextStyle(
              color: ColorConstants.blue,
            ),
          ),
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
            Text(
              countryFlag.toUpperCase().replaceAllMapped(
                    RegExp(r'[A-Z]'),
                    (match) => String.fromCharCode(
                      match.group(0)!.codeUnitAt(0) + 127397,
                    ),
                  ),
            ),
            SizedBox(width: 4.w),
            Text(
              countryCode,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
