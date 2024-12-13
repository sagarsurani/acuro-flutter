import 'package:acuro/core/constants/Constants.dart';
import 'package:acuro/core/utils/TimeUtils.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'UserModel.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? email;
  String? phoneNumber;
  @JsonKey(
      fromJson: TimeUtils.fromIso8601String, toJson: TimeUtils.toIso8601String)
  DateTime? createdAt;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.createdAt,
  });

  factory UserModel.fromJson(Json json) => _$UserModelFromJson(json);

  Json toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phoneNumber,
        createdAt,
      ];
}
