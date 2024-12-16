// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OtpLimitationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPLimitationModel _$OTPLimitationModelFromJson(Map<String, dynamic> json) =>
    OTPLimitationModel(
      otpFrom: json['otpFrom'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      limit: (json['limit'] as num).toInt(),
      time: json['time'] as String,
    );

Map<String, dynamic> _$OTPLimitationModelToJson(OTPLimitationModel instance) =>
    <String, dynamic>{
      'otpFrom': instance.otpFrom,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'limit': instance.limit,
      'time': instance.time,
    };
