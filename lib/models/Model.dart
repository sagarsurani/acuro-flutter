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
