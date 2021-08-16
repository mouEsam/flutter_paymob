// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

const String NA = "NA";

String paymentToJson(Payment data) => json.encode(data.toJson());

@JsonSerializable(createFactory: false)
class Payment {
  Payment({
    required this.paymentKey,
    this.token,
    this.saveCardDefault = false,
    this.showSaveCard = true,
    this.themeColor,
    this.language,
    this.actionbar = true,
    this.maskedPanNumber,
    this.customer,
  });

  String paymentKey;
  bool saveCardDefault;
  bool showSaveCard;
  @JsonKey(toJson: _colorToHex)
  Color? themeColor;
  @JsonKey(toJson: _localeToLanguage)
  Locale? language;
  bool actionbar;
  String? token;
  String? maskedPanNumber;
  Customer? customer;

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}

String _localeToLanguage(Locale? locale) => locale?.languageCode ?? 'en';

String? _colorToHex(Color? color) {
  return color == null ? null : '#${color.value.toRadixString(16)}';
}

@JsonSerializable(createFactory: false)
class Customer {
  Customer({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.building,
    this.floor,
    this.apartment,
    this.city,
    this.state,
    this.country,
    this.postalCode,
  });

  @JsonKey(defaultValue: NA)
  String firstName;
  @JsonKey(defaultValue: NA)
  String lastName;
  @JsonKey(defaultValue: NA)
  String email;
  @JsonKey(defaultValue: NA)
  String phoneNumber;
  @JsonKey(toJson: _valueOrNA)
  String? apartment;
  @JsonKey(toJson: _valueOrNA)
  String? floor;
  @JsonKey(toJson: _valueOrNA)
  String? street;
  @JsonKey(toJson: _valueOrNA)
  String? building;
  @JsonKey(toJson: _valueOrNA)
  String? postalCode;
  @JsonKey(toJson: _valueOrNA)
  String? city;
  @JsonKey(toJson: _valueOrNA)
  String? country;
  @JsonKey(toJson: _valueOrNA)
  String? state;

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}

String _valueOrNA(Object? value) => value?.toString() ?? NA;
