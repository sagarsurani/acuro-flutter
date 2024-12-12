

import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CommonAuthHeader extends StatefulWidget {
  final String headerText;
  final String bodyText;
  const CommonAuthHeader({super.key, required this.headerText, required this.bodyText});

  @override
  State<CommonAuthHeader> createState() => _CommonAuthHeaderState();
}

class _CommonAuthHeaderState extends State<CommonAuthHeader> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.headerText,
            style: textWith24W500(Theme.of(context).focusColor),
          ),
          SizedBox(height: 4.h),
          Text(
            widget.bodyText,
            style: textWith14W400(Theme.of(context).canvasColor),
          ),
        ],
      ),
    );;
  }
}
