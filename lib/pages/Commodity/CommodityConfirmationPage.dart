import 'package:acuro/components/Common/CommonBackgroundView.dart';
import 'package:acuro/components/Common/CommonButton.dart';
import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/core/constants/Constants.dart';
import 'package:acuro/core/constants/ImageConstants.dart';
import 'package:acuro/core/navigator/AppRouter.gr.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:acuro/models/Model.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class CommodityConfirmationPage extends StatefulWidget {
  final List<CommodityModel> selectedCommodityList;
  const CommodityConfirmationPage(
      {super.key, required this.selectedCommodityList});

  @override
  State<CommodityConfirmationPage> createState() =>
      _CommodityConfirmationPageState();
}

class _CommodityConfirmationPageState extends State<CommodityConfirmationPage> {
  CommodityStatus commodityStatus = CommodityStatus.confirm;
  String userName = "Steve";

  List<MarketModel> combineMarketList(CommodityModel commodity) {
    return [...commodity.spotMarket, ...commodity.futureMarket]
        .where((market) => market.isSelected)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.only(
              bottom: 24.h, left: 20.w, right: 20.w),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    headerView(),
                    verifyTitle(),
                    viewSelectedCommodityWidget(),
                  ],
                ),
              ),
              Positioned(bottom: 1.h, left: 1.h, right: 1.w, child: button())
            ],
          ),
        ),
      ),
    );
  }

  Widget headerView() {
    var appText = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 80.h),
        if (commodityStatus == CommodityStatus.confirm) ...[
          Image.asset(
              AppUtils.isDarkTheme(context)
                  ? ImageConstants.imgConfirmSelectionDark
                  : ImageConstants.imgConfirmSelection,
              height: 138.r,
              width: 138.r)
        ] else ...[
          Image.asset(
              AppUtils.isDarkTheme(context)
                  ? ImageConstants.imgVerifyingDark
                  : ImageConstants.imgVerifying,
              height: 138.r,
              width: 138.r)
        ],
        SizedBox(height: 12.h),
        SizedBox(
          width: 304.w,
          child: Text(
            "$userName ${commodityStatus == CommodityStatus.confirm ? appText.we_just_want_to_confirm_your_selection : appText.we_are_verifying_your_account_information}",
            textAlign: TextAlign.center,
            style: textWith24W500(Theme.of(context).focusColor),
          ),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget verifyTitle() {
    var appText = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (commodityStatus == CommodityStatus.confirm) ...[
          Text(
            appText.we_just_want_to_confirm_you_commodity_selection,
            textAlign: TextAlign.center,
            style: textWith14W400(ColorConstants.red),
          ),
        ] else ...[
          Container(
            decoration: BoxDecoration(
                color: ColorConstants.yellow.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(width: 1.w, color: ColorConstants.yellow)),
            padding: EdgeInsets.all(6.r),
            child: Text(
              commodityStatus == CommodityStatus.pendingWithCustomerSupport
                  ? appText.hang_tight_the_verification_is_taking_longer
                  : appText.we_just_want_to_confirm_you_commodity_selection,
              textAlign: TextAlign.center,
              style: textWith14W400(Theme.of(context).focusColor),
            ),
          ),
        ],
        SizedBox(height: 54.h),
      ],
    );
  }

  Widget viewSelectedCommodityWidget() {
    var appText = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              appText.commodities,
              style: textWith20W500(Theme.of(context).focusColor),
            ),
            if (commodityStatus == CommodityStatus.confirm) ...[
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 35.h,
                  width: 61.w,
                  decoration: BoxDecoration(
                      color: AppUtils.isDarkTheme(context)
                          ? ColorConstants.blackLight
                          : ColorConstants.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100.r)),
                  child: Center(
                    child: Text(
                      appText.edit,
                      style: textWith16W700(ColorConstants.blue),
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
        SizedBox(height: 21.h),
        Container(
          margin: EdgeInsets.only(bottom: 60.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                  color: Theme.of(context).dividerColor, width: 1.h)),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: widget.selectedCommodityList.length,
            itemBuilder: (context, index) {
              String commodity = widget.selectedCommodityList[index].name;
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      commodity,
                      style: textWith18W500(Theme.of(context).focusColor),
                    ),
                    SizedBox(height: 5.h),
                    Wrap(
                      spacing: 10.w,
                      runSpacing: 21.h,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runAlignment: WrapAlignment.start,
                      children:
                          combineMarketList(widget.selectedCommodityList[index])
                              .map((market) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImageConstants.imgUsaDummy,
                              height: 12.r,
                              width: 12.r,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              market.name,
                              style: textWith12W500(
                                  AppUtils.isDarkTheme(context)
                                      ? ColorConstants.greyLight
                                      : ColorConstants.greyDark1),
                            ),
                          ],
                        );
                      }).toList(),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                  height: 1.h, color: Theme.of(context).dividerColor);
            },
          ),
        ),
      ],
    );
  }

  Widget button() {
    var appText = AppLocalizations.of(context)!;
    return Visibility(
      visible: commodityStatus != CommodityStatus.pending,
      child: CommonButton(
          onTap: () {
            if (commodityStatus == CommodityStatus.confirm) {
              commodityStatus = CommodityStatus.pending;
              setState(() {});
              Future.delayed(
                const Duration(seconds: 5),
                () {
                  commodityStatus = CommodityStatus.pendingWithCustomerSupport;
                  setState(() {});
                },
              );
            } else {
              context.router.popUntilRouteWithName(SelectRoleRoute.name);
            }
          },
          buttonText:
              commodityStatus == CommodityStatus.pendingWithCustomerSupport
                  ? appText.connect_support
                  : appText.submit),
    );
  }
}