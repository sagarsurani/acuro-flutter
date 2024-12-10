
import 'package:acuro/components/Common/AnimatedSwitcher.dart';
import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/components/Login/CommonAuthHeader.dart';
import 'package:acuro/core/constants/Constants.dart';
import 'package:acuro/core/constants/ImageConstants.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:acuro/models/Model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class SelectRolePage extends StatefulWidget {
  const SelectRolePage({super.key});

  @override
  State<SelectRolePage> createState() => _SelectRolePageState();
}

class _SelectRolePageState extends State<SelectRolePage> {
  List<RoleSelectionModel> roleList = [];

  @override
  void initState() {
    roleList = roleSelectionListStatic;
    super.initState();
  }

  Color roleComponentColor(RoleSelectionEnum role) {
    return role == RoleSelectionEnum.comingSoon
        ? ColorConstants.countryBackground
        : role == RoleSelectionEnum.selected
            ? ColorConstants.blue.withOpacity(0.1)
            : ColorConstants.black1;
  }

  Color roleComponentTextColor(RoleSelectionEnum role) {
    return role == RoleSelectionEnum.comingSoon
        ? ColorConstants.roleComingText
        : role == RoleSelectionEnum.selected
            ? ColorConstants.blue
            : ColorConstants.black1;
  }

  Color roleComponentBorderColor(RoleSelectionEnum role) {
    return role == RoleSelectionEnum.selected
        ? ColorConstants.blue
        : Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    var appText = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorConstants.white1,
      body: Padding(
        padding:
            EdgeInsets.only(top: 90.h, bottom: 24.h, left: 20.w, right: 20.w),
        child: SmootherView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CommonBackView(
              //   onTap: () {
              //     Navigator.of(context);
              //   },
              // ),
              SizedBox(height: 14.h),
              // content view
              CommonAuthHeader(
                  headerText: appText.select_your_role,
                  bodyText: appText.choose_how_you_primarily_interact),
              SizedBox(height: 32.h),

              // content view
              selectRoleView()
            ],
          ),
        ),
      ),
    );
  }

  Widget selectRoleView() {
    return Expanded(
      child: ListView.separated(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            RoleSelectionEnum role = roleList[index].roleSelectionEnum;
            return Container(
              padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 12.w),
              decoration: BoxDecoration(
                  color: roleComponentColor(role),
                  border: Border.all(
                      width: 1.h, color: roleComponentBorderColor(role)),
                  borderRadius: BorderRadius.circular(15.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          roleList[index].roleName,
                          style: textWith20W500(roleComponentTextColor(role)),
                        ),
                        Text(
                          roleList[index].roleDescription,
                          style: textWith14W400(roleComponentTextColor(role)),
                        )
                      ],
                    ),
                  ),

                  // role selection tag
                  selectionTagWidget(role)
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 16.h);
          },
          itemCount: roleList.length),
    );
  }

  Widget selectionTagWidget(RoleSelectionEnum role) {
    var appText = AppLocalizations.of(context)!;
    return role == RoleSelectionEnum.comingSoon
        ? Text(
          appText.coming_soon,
          style: textWith10W500(ColorConstants.green),
        )
        : role == RoleSelectionEnum.selected
            ? SvgPicture.asset(
                ImageConstants.icRightBlue,
              )
            : const SizedBox.shrink();
  }
}
