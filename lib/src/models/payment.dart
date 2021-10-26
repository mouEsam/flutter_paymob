// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

import '../utils/json_utils.dart';

part 'payment.g.dart';

String paymentToJson(Payment data) => json.encode(data.toJson());

@JsonSerializable(createFactory: false)
class Payment {
  Payment({
    required this.paymentKey,
    required this.authToken,
    required this.orderId,
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
  String authToken;
  String orderId;
  bool saveCardDefault;
  bool showSaveCard;
  @JsonKey(toJson: colorToHex)
  Color? themeColor;
  @JsonKey(toJson: localeToLanguage)
  Locale? language;
  bool actionbar;
  String? token;
  String? maskedPanNumber;
  Customer? customer;

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
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
  @JsonKey(toJson: valueOrNA)
  String? apartment;
  @JsonKey(toJson: valueOrNA)
  String? floor;
  @JsonKey(toJson: valueOrNA)
  String? street;
  @JsonKey(toJson: valueOrNA)
  String? building;
  @JsonKey(toJson: valueOrNA)
  String? postalCode;
  @JsonKey(toJson: valueOrNA)
  String? city;
  @JsonKey(toJson: valueOrNA)
  String? country;
  @JsonKey(toJson: valueOrNA)
  String? state;

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
