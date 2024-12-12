import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/AppColors.dart';
import 'CommonTextStyle.dart';

class CommonTabHeaderView extends StatefulWidget {
  final TabController controller;
  final int currentIndex;
  final List<String> tabsList;
  final void Function(int index) onTabChanged;
  final Color? textColor;
  final Color? selectedTextColor;
  final TextStyle? selectedTextStyle;
  final TextStyle? textStyle;

  const CommonTabHeaderView(
      {super.key,
      required this.controller,
      required this.tabsList,
      required this.currentIndex,
      this.textColor,
      this.selectedTextColor,
      required this.onTabChanged,
      this.selectedTextStyle,
      this.textStyle});

  @override
  State<CommonTabHeaderView> createState() => _CommonTabHeaderViewState();
}

class _CommonTabHeaderViewState extends State<CommonTabHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
            color: Theme.of(context).tabBarTheme.unselectedLabelColor,
            borderRadius: BorderRadius.circular(100.r)),
        child: TabBar(
            controller: widget.controller,
            indicatorWeight: 0.1,
            physics: const NeverScrollableScrollPhysics(),
            isScrollable: false,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerHeight: 0,
            automaticIndicatorColorAdjustment: false,
            padding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            onTap: (index) => widget.onTabChanged(index),
            tabs: List.generate(
              widget.tabsList.length,
              (index) {
                return tabItemView(
                    text: widget.tabsList[index],
                    isSelected: (index == widget.currentIndex));
              },
            )));
  }

  Widget tabItemView({required String text, required bool isSelected}) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).tabBarTheme.indicatorColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(100.r)),
      child: Text(
        text,
        style: isSelected
            ? (widget.selectedTextStyle != null)
                ? widget.selectedTextStyle
                : textWith14W500(Theme.of(context).focusColor)
            : (widget.textStyle != null)
                ? widget.textStyle
                : textWith14W500(ColorConstants.grey2),
      ),
    );
  }
}
