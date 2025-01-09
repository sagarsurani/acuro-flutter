// ignore_for_file: constant_identifier_names

import '../../models/Model.dart';


/// static app keywords
typedef Json = Map<String, dynamic>;
const ACURO = "Acuro";
const AEONIK = "Aeonik";
const HEADER_PROTECTED_AUTHENTICATION_PREFIX = 'Bearer';
const HEADER_AUTHORIZATION = 'Authorization';
const APPLICATION_JSON = 'application/json';
const BEARER = 'Bearer';
const CONTENT_TYPE = 'Content-Type';
const AUTHORIZATION = 'Authorization';
const PHONEAUTH = "phone";
const EMAILAUTH = "email";
const FORGOTPHONE = "forgotphone";
const FORGOTEMAIL = "forgotmail";
const PHONENUMBER = "phoneNumber";
const EMAIL = "email";
const OTPFROM = "otpFrom";
const SOMETHING_WANT_WRONG = "Somethings want wrong";
const NUMBER_NOT_REGISTER = "Number not registered";
const EMAIL_NOT_REGISTER = "Email not registered";
const SO_MANY_ATTEMPT = "So many attempt";
const OTP = "otp";
const TOKEN = "token";
const BLOCKED = "blocked";
const COUNTRIES = "countries";
const REVERSE_CLIENT_ID = "com.googleusercontent.apps.361342922595-i52p5bdsq6tdcf8p41eev26bjl416v6h";

/// cloud and service account urls

const String updatePasswordUrl =
    "https://us-central1-acuro-app-qa.cloudfunctions.net/updatePassword";

const String senEmailOtpFunctionUrl =
    "https://us-central1-acuro-app-qa.cloudfunctions.net/sendEmail";

const String verifyEmailOtpFunctionUrl =
    "https://us-central1-acuro-app-qa.cloudfunctions.net/verifyEmailOtp";

const String generateServiceTokenUrl =
    "https://iamcredentials.googleapis.com/v1/projects/-/serviceAccounts/361342922595-compute@developer.gserviceaccount.com:generateIdToken";

List<String> GOOGLECLOUDSCOPE = [
  'https://www.googleapis.com/auth/iam',
  'https://www.googleapis.com/auth/cloud-platform',
  'https://www.googleapis.com/auth/firebase.database',
  'https://www.googleapis.com/auth/userinfo.email',
];

/// load json

const String LOADCOUNTRYJSON = "assets/cloud/countries.json";
const String LOADSERVICEACCOUNTJSON = "assets/cloud/acuro_service.json";
/// constants enum

enum RoleSelectionEnum { selected, unSelected, comingSoon }

enum OTPEnum { phone, email, forgotPassword }

enum CommodityStatus { confirm, pending, pendingWithCustomerSupport }

enum LoginType { signInWithEmail, signInWithPhone }


/// Dummy UI data

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

