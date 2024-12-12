import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../core/theme/AppColors.dart';

class OtpView extends StatefulWidget {
  final TextEditingController controller;
  final bool hasError;
  final Function(String) onChanged;
  const OtpView(
      {super.key,
      required this.controller,
      required this.hasError,
      required this.onChanged});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      keyboardType: TextInputType.number,
      appContext: context,
      obscureText: false,
      animationType: AnimationType.fade,
      inputFormatters: AppUtils.onlyDigitsFormatter(0),
      textStyle: textWith20W400(Theme.of(context).focusColor),
      pinTheme: PinTheme(
        inactiveFillColor: Theme.of(context).secondaryHeaderColor,
        inactiveColor: widget.hasError
            ? ColorConstants.red
            : Theme.of(context).secondaryHeaderColor,
        activeColor: widget.hasError
            ? ColorConstants.red
            : Theme.of(context).secondaryHeaderColor,
        activeFillColor: Theme.of(context).secondaryHeaderColor,
        selectedColor: widget.hasError
            ? ColorConstants.red
            : Theme.of(context).secondaryHeaderColor,
        selectedFillColor: Theme.of(context).secondaryHeaderColor,
        shape: PinCodeFieldShape.box,
        errorBorderColor: ColorConstants.red,
        errorBorderWidth: 1,
        borderRadius: BorderRadius.circular(15.r),
        fieldHeight: 61.h,
        fieldWidth: MediaQuery.of(context).size.width / 8,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      autoDisposeControllers: false,
      enableActiveFill: true,
      controller: widget.controller,
      onChanged: widget.onChanged,
    );
  }
}
