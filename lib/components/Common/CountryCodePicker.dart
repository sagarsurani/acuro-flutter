import 'package:acuro/core/theme/AppColors.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:country_flags/country_flags.dart';
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
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            searchTextStyle: TextStyle(
              color: Theme.of(context).focusColor,
            ),
            textStyle: TextStyle(
              color: Theme.of(context).focusColor,
            ),
          ),
        );
      },
      child: Container(
        height: 61.h,
        width: 73.w,
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
                child: CountryFlag.fromCountryCode(countryFlag,
                    height: 24.r, width: 24.r)),
            SizedBox(width: 4.w),
            Text(
              countryCode,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).focusColor),
            ),
          ],
        ),
      ),
    );
  }
}
