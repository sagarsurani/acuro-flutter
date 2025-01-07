

import 'package:acuro/core/constants/Constants.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'CountryModel.g.dart';

@JsonSerializable()
class CountryModel extends Equatable {
  final String code;
  final String label;
  final String phone;
  final dynamic phoneLength;

  CountryModel({
    required this.code,
    required this.label,
    required this.phone,
    required this.phoneLength,
  });

  factory CountryModel.fromJson(Json json) => _$CountryModelFromJson(json);

  Json toJson() => _$CountryModelToJson(this);

  @override
  List<Object?> get props => [code, label, phone, phoneLength];
}


