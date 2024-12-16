

import 'package:acuro/core/constants/Constants.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'OtpLimitationModel.g.dart';

@JsonSerializable(explicitToJson: true)
class OTPLimitationModel extends Equatable {
  String otpFrom;
  String email;
  String phoneNumber;
  int limit;
  String time;

  OTPLimitationModel({
    required this.otpFrom,
    required this.email,
    required this.phoneNumber,
    required this.limit,
    required this.time,
  });

  factory OTPLimitationModel.fromJson(Json json) =>
      _$OTPLimitationModelFromJson(json);

  Json toJson() => _$OTPLimitationModelToJson(this);

  @override
  List<Object?> get props => [
    otpFrom,
    email,
    phoneNumber,
    limit,
    time,
  ];
}