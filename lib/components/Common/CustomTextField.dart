// ignore_for_file: must_be_immutable

import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/core/constants/GlobalConstant.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/AppColors.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final bool? isReadOnly;
  final bool? isPng;
  final Color? backgroundColor;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final double? borderRadius;
  final String? suffixIcon;
  final TextStyle? fontStyle;
  final TextStyle? hintStyle;
  final String? hint;
  final int? maxLines;
  final int? minLines;
  final String? obscuringCharacter;
  final TextCapitalization? textCapitalization;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isObscureText;
  final bool? isShadowRemoved;
  final bool? enableSuggestions;
  final TextInputAction? textInputAction;
  final BoxShadow? boxShadow;
  void Function()? onTapOnIcon;
  void Function(String)? onChanged;
  void Function(String)? onFieldSubmitted;
  void Function()? onTapOnTextField;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final AlignmentGeometry? alignment;
  final List<TextInputFormatter>? inputFormatters;

  CustomTextField(
      {super.key,
      this.label,
      this.backgroundColor,
      this.controller,
      this.alignment,
      this.focusNode,
      this.onChanged,
      this.onFieldSubmitted,
      this.suffixIcon,
      this.textCapitalization,
      this.enableSuggestions,
      this.hint,
      this.minLines,
      this.isPng,
      this.boxShadow,
      this.isObscureText,
      this.contentPadding,
      this.obscuringCharacter,
      this.maxLines,
      this.isShadowRemoved,
      this.fontStyle,
      this.hintStyle,
      this.borderRadius,
      this.keyboardType,
      this.onTapOnIcon,
      this.textInputAction,
      this.onTapOnTextField,
      this.suffixWidget,
      this.prefixWidget,
      this.isReadOnly,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 61.h,
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: backgroundColor ?? ColorConstants.textFieldColor,
      ),
      child: TextField(
        cursorColor: ColorConstants.blue,
        cursorWidth: 2,
        obscureText: isObscureText ?? false,
        focusNode: focusNode,
        textAlign: TextAlign.start,
        textCapitalization: textCapitalization ?? TextCapitalization.sentences,
        maxLines: maxLines ?? 1,
        minLines: minLines ?? 1,
        autocorrect: false,
        enableSuggestions: enableSuggestions ?? true,
        obscuringCharacter: obscuringCharacter ?? "•",
        readOnly: isReadOnly ?? false,
        textInputAction: textInputAction ?? TextInputAction.next,
        controller: controller,
        onTap: onTapOnTextField,
        onChanged: onChanged,
        onSubmitted: onFieldSubmitted,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters ?? [],
        style: fontStyle ?? textWith20W400(ColorConstants.black1),
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          hintStyle: hintStyle ?? textWith20W400(ColorConstants.grey2),
          contentPadding: contentPadding ?? EdgeInsets.all(16.r),
          border: InputBorder.none,
          prefixIcon: prefixWidget,
          suffixIcon: (suffixIcon != null)
              ? InkWell(
                  onTap: onTapOnIcon ?? () {},
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: (isPng != null && isPng == true)
                        ? Image.asset(
                            suffixIcon!,
                            height: 22.r,
                            width: 22.r,
                          )
                        : SvgPicture.asset(suffixIcon!),
                  ),
                )
              : suffixWidget,
        ),
      ),
    );
  }
}
