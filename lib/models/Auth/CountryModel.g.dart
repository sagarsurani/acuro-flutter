// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CountryModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) => CountryModel(
      code: json['code'] as String,
      label: json['label'] as String,
      phone: json['phone'] as String,
      phoneLength: json['phoneLength'],
    );

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'label': instance.label,
      'phone': instance.phone,
      'phoneLength': instance.phoneLength,
    };
