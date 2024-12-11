import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

textWith10W500(
    Color color,
    ) {
  return TextStyle(color: color, fontSize: 10.sp, fontWeight: FontWeight.w500);
}

textWith12W500(
    Color color,
    ) {
  return TextStyle(color: color, fontSize: 12.sp, fontWeight: FontWeight.w500);
}

textWith14W400(
    Color color,
    ) {
  return TextStyle(color: color, fontSize: 14.sp, fontWeight: FontWeight.w400);
}

textWith14W500(
  Color color,
) {
  return TextStyle(color: color, fontSize: 14.sp, fontWeight: FontWeight.w500);
}


textWith16W400(
    Color color,
    ) {
  return TextStyle(color: color, fontSize: 16.sp, fontWeight: FontWeight.w400);
}


textWith16W500(
    Color color,
    ) {
  return TextStyle(color: color, fontSize: 16.sp, fontWeight: FontWeight.w500);
}


textWith16W700(
    Color color,
    ) {
  return TextStyle(color: color, fontSize: 16.sp, fontWeight: FontWeight.w700);
}

textWith18W500(
    Color color,
    ) {
  return TextStyle(color: color, fontSize: 18.sp, fontWeight: FontWeight.w500);
}

textWith20W400(
    Color color,
    ) {
  return TextStyle(color: color, fontSize: 20.sp, fontWeight: FontWeight.w400);
}

textWith20W500(
    Color color,
    ) {
  return TextStyle(color: color, fontSize: 20.sp, fontWeight: FontWeight.w500);
}

textWith24W500(
    Color color,
    ) {
  return TextStyle(color: color, fontSize: 24.sp, fontWeight: FontWeight.w500);
}

textWith40W700(
    Color color,
    ) {
  return TextStyle(color: color, fontSize: 40.sp, fontWeight: FontWeight.w700,height: 1.h);
}

textWith40W500WithGradient(
    List<Color> colors,
    ) {
  return TextStyle(
      fontSize: 40.sp,
      fontWeight: FontWeight.w700,
      foreground: Paint()
        ..shader = LinearGradient(
          colors: colors,
        ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))
  );
}
