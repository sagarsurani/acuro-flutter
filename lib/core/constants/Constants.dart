// ignore_for_file: constant_identifier_names

import '../../models/Model.dart';

typedef Json = Map<String, dynamic>;

const ACURO = "Acuro";
const AEONIK = "Aeonik";
const HEADER_PROTECTED_AUTHENTICATION_PREFIX = 'Bearer';
const HEADER_AUTHORIZATION = 'Authorization';
const APPLICATION_JSON = 'application/json';
const CONTENT_TYPE = 'Content-Type';

enum RoleSelectionEnum { selected, unSelected, comingSoon }

enum OTPEnum { phone, email, forgotPassword }

enum CommodityStatus { confirm, pending, pendingWithCustomerSupport }

enum LoginType { signInWithEmail, signInWithPhone }

//

const PHONEAUTH = "phone";
const EMAILAUTH = "email";
const FORGOTPHONE = "forgotphone";
const FORGOTEMAIL = "forgotmail";
const SOMETHING_WANT_WRONG = "Somethings want wrong";
const NUMBER_NOT_REGISTER = "Number not registered";
const SO_MANY_ATTEMPT = "So many attempt";
const OTP = "otp";
const BLOCKED = "blocked";

List<RoleSelectionModel> roleSelectionListStatic = [
  RoleSelectionModel(
      roleName: "Buyer",
      roleDescription:
          "Buy commodities at optimal prices for your organization's needs",
      roleSelectionEnum: RoleSelectionEnum.selected),
  RoleSelectionModel(
      roleName: "Seller",
      roleDescription:
          "Sell commodities at optimal prices for your organization's needs",
      roleSelectionEnum: RoleSelectionEnum.comingSoon),
  RoleSelectionModel(
      roleName: "Trader",
      roleDescription:
          "Trade commodities across exchanges to capitalize on market opportunities",
      roleSelectionEnum: RoleSelectionEnum.comingSoon),
];

final List<String> tabsList = ["Email", "Mobile"];

List<CommodityModel> commodityListStatic = [
  CommodityModel(name: "Sunflower oil", isOpened: true, spotMarket: [
    MarketModel(name: "FOB Black Sea", isSelected: false, flag: ""),
  ], futureMarket: [
    MarketModel(name: "FOB Black Sea 1", isSelected: false, flag: ""),
  ]),
  CommodityModel(name: "Crude Palm Oil", isOpened: false, spotMarket: [
    MarketModel(name: "FOB Black Sea 4", isSelected: false, flag: ""),
  ], futureMarket: [
    MarketModel(name: "Black Sea 1", isSelected: false, flag: ""),
  ]),
  CommodityModel(name: "Soybean Oil", isOpened: false, spotMarket: [
    MarketModel(name: "FOB Black Sea", isSelected: false, flag: ""),
  ], futureMarket: [
    MarketModel(name: "FOB Black 1", isSelected: false, flag: ""),
  ]),
  CommodityModel(name: "Rapeseed Oil", isOpened: false, spotMarket: [
    MarketModel(name: "FOB Black Sea 3", isSelected: false, flag: ""),
  ], futureMarket: [
    MarketModel(name: "FOB Black Sea 12", isSelected: false, flag: ""),
  ]),
];

List<CommodityCategoryModel> commodityCategoryListStatic = [
  CommodityCategoryModel(name: "Agriculture", isSelected: true),
  CommodityCategoryModel(name: "Energy", isSelected: false),
  CommodityCategoryModel(name: "Metals", isSelected: false),
  CommodityCategoryModel(name: "Chemicals", isSelected: false),
];
