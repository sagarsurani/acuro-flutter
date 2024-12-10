// ignore_for_file: constant_identifier_names

import '../../models/Model.dart';

typedef Json = Map<String, dynamic>;

const ACURO = "Acuro";
const AEONIK = "Aeonik";

enum RoleSelectionEnum { selected, unSelected, comingSoon }

List<RoleSelectionModel> roleSelectionListStatic = [
  RoleSelectionModel(
      roleName: "Buyer",
      roleDescription:
          "Buy commodities at optimal prices for your organization's needs",
      roleSelectionEnum: RoleSelectionEnum.selected),
  RoleSelectionModel(
      roleName: "Trader",
      roleDescription:
          "Trade commodities across exchanges to capitalize on market opportunities",
      roleSelectionEnum: RoleSelectionEnum.comingSoon),
];
