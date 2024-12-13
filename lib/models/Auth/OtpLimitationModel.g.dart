// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OtpLimitationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPLimitationModel _$OTPLimitationModelFromJson(Map<String, dynamic> json) =>
    OTPLimitationModel(
      otpFrom: json['otpFrom'] as String,
      emailOrPhoneName: json['emailOrPhoneName'] as String,
      limit: (json['limit'] as num).toInt(),
      time: json['time'] as String,
    );

Map<String, dynamic> _$OTPLimitationModelToJson(OTPLimitationModel instance) =>
    <String, dynamic>{
      'otpFrom': instance.otpFrom,
      'emailOrPhoneName': instance.emailOrPhoneName,
      'limit': instance.limit,
      'time': instance.time,
    };
