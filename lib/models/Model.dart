import 'package:acuro/core/constants/Constants.dart';

class RoleSelectionModel {
  final String roleName;
  final String roleDescription;
  final RoleSelectionEnum roleSelectionEnum;

  RoleSelectionModel(
      {required this.roleName,
      required this.roleSelectionEnum,
      required this.roleDescription});
}

class CommodityCategoryModel {
  final String name;
  bool isSelected;

  CommodityCategoryModel(
      {required this.name, required this.isSelected});
}

class CommodityModel {
  final String name;
  bool isOpened;
  final List<MarketModel> spotMarket;
  final List<MarketModel> futureMarket;

  CommodityModel({
    required this.name,
    required this.isOpened,
    required this.spotMarket,
    required this.futureMarket,
  });
}

class MarketModel {
  final String name;
  final String flag;
  bool isSelected;

  MarketModel(
      {required this.name, required this.flag, required this.isSelected});
}
