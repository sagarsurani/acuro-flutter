import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/core/constants/ImageConstants.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Single error common view

class AuthErrorView extends StatelessWidget {
  final bool isError;
  final String errorText;
  const AuthErrorView(
      {super.key, required this.isError, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return isError
        ? Text(
            errorText,
            style: textWith16W400(ColorConstants.red),
          )
        : const SizedBox.shrink();
  }
}


// Multiple error common view

class MultipleErrorWidget extends StatelessWidget {
  final List<String> errors;
  const MultipleErrorWidget({super.key, required this.errors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: errors.map((error) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(ImageConstants.icRedClose),
              SizedBox(width: 2.w),
              Flexible(
                child: Text(
                  error,
                  style: textWith14W400(ColorConstants.red),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
