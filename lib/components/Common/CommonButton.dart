
import 'package:acuro/core/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'CommonTextStyle.dart';

class CommonButton extends StatefulWidget {
  final Function() onTap;
  final String buttonText;
  final String? suffixIcon;
  final double? iconSize;
  final Color? iconColor;
  final TextStyle? textStyle;
  final Color? backGroundColor;
  final double? borderRadius;
  final double? loaderSize;
  final Color? loaderColor;
  final bool? boxShadowHide;
  final bool? isLoading;
  final EdgeInsetsGeometry? margin;

  const CommonButton(
      {super.key,
      required this.onTap,
      required this.buttonText,
      this.borderRadius,
      this.loaderColor,
      this.loaderSize,
      this.textStyle,
      this.backGroundColor,
      this.suffixIcon,
      this.iconSize,
      this.boxShadowHide,
      this.isLoading,
      this.margin,
      this.iconColor});

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (widget.isLoading ?? false) ? () {} : widget.onTap,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onDoubleTap: widget.onTap,
      borderRadius: BorderRadius.circular(15.r),
      child: Container(
        height: 48.h,
        padding: EdgeInsets.all(6.r),
        margin: widget.margin,
        decoration: BoxDecoration(
          color: widget.backGroundColor ?? ColorConstants.blue,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 15.r),
        ),
        child: (widget.isLoading ?? false) ? loaderView() : buttonTextView(),
      ),
    );
  }

  Widget loaderView() {
    return SpinKitThreeBounce(
      color: widget.loaderColor ?? Colors.white,
      size: widget.loaderSize ?? 24.r,
    );
  }

  Widget buttonTextView() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              widget.buttonText,
              overflow: TextOverflow.ellipsis,
              style: widget.textStyle ?? textWith16W700(ColorConstants.white1),
            ),
          ),
          if (widget.suffixIcon != null) ...[
            SizedBox(width: 5.w),
            SvgPicture.asset(
              widget.suffixIcon!,
              height: widget.iconSize ?? 12.r,
              color: widget.iconColor,
            )
          ],
        ],
      ),
    );
  }
}
