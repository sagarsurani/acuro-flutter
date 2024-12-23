import 'package:acuro/components/Common/CommonBackgroundView.dart';
import 'package:acuro/components/Common/CommonButton.dart';
import 'package:acuro/components/Common/CommonSplashBackView.dart';
import 'package:acuro/components/Common/CommonTextStyle.dart';
import 'package:acuro/components/Common/CustomTextField.dart';
import 'package:acuro/core/constants/Constants.dart';
import 'package:acuro/core/constants/ImageConstants.dart';
import 'package:acuro/core/navigator/AppRouter.gr.dart';
import 'package:acuro/core/theme/AppColors.dart';
import 'package:acuro/core/utils/AppUtils.dart';
import 'package:acuro/models/Model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class SelectCommodityPage extends StatefulWidget {
  const SelectCommodityPage({super.key});

  @override
  State<SelectCommodityPage> createState() => _SelectCommodityPageState();
}

class _SelectCommodityPageState extends State<SelectCommodityPage> {
  final searchController = TextEditingController();
  List<CommodityModel> commodityList = [];
  List<CommodityModel> selectedCommodityList = [];
  List<CommodityCategoryModel> commodityCategoryList = [];

  @override
  void initState() {
    super.initState();
    commodityList = commodityListStatic;
    commodityCategoryList = commodityCategoryListStatic;
  }

  void navigateToConfirmCommodityPage() {
    if (selectedCommodityList.isNotEmpty) {
      context.router.push(CommodityConfirmationRoute(
          selectedCommodityList: selectedCommodityList));
    }
  }

  int totalSelectedMarketCount(CommodityModel commodity) {
    return commodity.spotMarket.where((element) => element.isSelected).length +
        commodity.futureMarket.where((element) => element.isSelected).length;
  }

  void tapCommodityCategory(CommodityCategoryModel category) {
    setState(() {
      category.isSelected = !category.isSelected;
    });
    for (var otherCategory in commodityCategoryList) {
      if (otherCategory != category) {
        otherCategory.isSelected = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var appText = AppLocalizations.of(context)!;
    return Scaffold(
      body: CommonBackgroundView(
        child: Padding(
          padding:
              EdgeInsets.only(top: 60.h, bottom: 24.h, left: 20.w, right: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // back view
              CommonBackView(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 14.h),
              Text(
                appText.select_commodity,
                style: textWith24W500(Theme.of(context).focusColor),
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                height: 48.h,
                alignment: Alignment.center,
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                controller: searchController,
                fontStyle: textWith16W400(Theme.of(context).focusColor),
                hintStyle: textWith16W400(Theme.of(context).hintColor),
                contentPadding: EdgeInsets.all(10.h),
                prefixWidget: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SvgPicture.asset(
                    ImageConstants.icSearch,
                    height: 16.r,
                    width: 16.r,
                  ),
                ),
                hint: appText.search,
                onChanged: (value) {},
              ),
              SizedBox(height: 16.h),
              // category selection
              commoditySelection(),
              SizedBox(height: 24.h),
              // contentView
              contentView(appText),
              SizedBox(height: 16.h),
              // submit button
              CommonButton(
                  onTap: navigateToConfirmCommodityPage,
                  isEnable: selectedCommodityList.isNotEmpty,
                  buttonText: appText.continueText)
            ],
          ),
        ),
      ),
    );
  }

  Widget commoditySelection() {
    return Wrap(
      spacing: 1.w,
      runSpacing: 8.h,
      children: commodityCategoryList.map((category) {
        return InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            tapCommodityCategory(category);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
            decoration: BoxDecoration(
                color: category.isSelected
                    ? Theme.of(context).secondaryHeaderColor
                    : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(100.r)),
            child: Text(
              category.name,
              style: textWith14W500(category.isSelected
                  ? Theme.of(context).focusColor
                  : Theme.of(context).hintColor),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget contentView(AppLocalizations appText) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: commodityList.length,
        itemBuilder: (context, index) {
          String commodity = commodityList[index].name;
          int selectedMarketCount =
              totalSelectedMarketCount(commodityList[index]);
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(
                    color: Theme.of(context).dividerColor, width: 1.h)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          commodityList[index].isOpened =
                              !commodityList[index].isOpened;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            commodity,
                            style: textWith18W500(Theme.of(context).focusColor),
                          ),
                          if (selectedCommodityList
                              .contains(commodityList[index])) ...[
                            InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  setState(() {
                                    selectedCommodityList
                                        .remove(commodityList[index]);
                                  });
                                },
                                child: SvgPicture.asset(
                                    ImageConstants.icRightBlue))
                          ] else ...[
                            InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  selectedCommodityList
                                      .add(commodityList[index]);
                                });
                              },
                              child: SizedBox(
                                height: 24.r,
                                width: 24.r,
                                child: Center(
                                    child: ClipOval(
                                        child: Image.asset(
                                            AppUtils.isDarkTheme(context)
                                                ? ImageConstants.imgAddDark
                                                : ImageConstants.imgAdd))),
                              ),
                            )
                          ]
                        ],
                      ),
                    ),
                  ),
                  if (selectedMarketCount > 0)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        "$selectedMarketCount ${appText.selected}",
                        style: textWith12W500(ColorConstants.blue),
                      ),
                    ),
                  if (commodityList[index].isOpened) ...[
                    SizedBox(height: 16.h),
                    marketWidget(commodityList[index])
                  ]
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 8.h);
        },
      ),
    );
  }

  Widget marketWidget(CommodityModel commodity) {
    var appText = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 14.h),
        Stack(
          children: [
            Divider(color: Theme.of(context).dividerColor),
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Container(
                height: 20.h,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadius.circular(5.r)),
                child: Text(
                  appText.select_up_to_five_market,
                  style: textWith12W500(Theme.of(context).canvasColor),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appText.spot_market,
                style: textWith14W500(Theme.of(context).canvasColor),
              ),
              SizedBox(height: 8.h),
              commonMarketSelectionView(commodity.spotMarket, commodity),
              SizedBox(height: 16.h),
              Text(
                appText.future_market,
                style: textWith14W500(Theme.of(context).canvasColor),
              ),
              SizedBox(height: 8.h),
              commonMarketSelectionView(commodity.futureMarket, commodity)
            ],
          ),
        )
      ],
    );
  }

  Widget commonMarketSelectionView(
      List<MarketModel> markets, CommodityModel commodity) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: markets.map((market) {
        return InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            setState(() {
              market.isSelected = !market.isSelected;
              if (market.isSelected) {
                if (!selectedCommodityList.contains(commodity)) {
                  selectedCommodityList.add(commodity);
                }
              }
            });
          },
          child: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: market.isSelected
                  ? ColorConstants.blue
                      .withOpacity(AppUtils.isDarkTheme(context) ? 0.3 : 0.1)
                  : Theme.of(context).secondaryHeaderColor,
              border: Border.all(
                  color: market.isSelected
                      ? ColorConstants.blue
                      : Colors.transparent,
                  width: 1.h),
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImageConstants.imgUsaDummy,
                  height: 20.r,
                  width: 20.r,
                ),
                SizedBox(width: 5.w),
                Text(
                  market.name,
                  style: textWith14W500(market.isSelected
                      ? ColorConstants.blue
                      : Theme.of(context).focusColor),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
