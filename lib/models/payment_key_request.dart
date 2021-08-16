// To parse this JSON data, do
//
//     final paymentKeyRequest = paymentKeyRequestFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_paymob/utils/json_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_key_request.g.dart';

String paymentKeyRequestToJson(PaymentKeyRequest data) =>
    json.encode(data.toJson());

@JsonSerializable(createFactory: false)
class PaymentKeyRequest {
  PaymentKeyRequest({
    required this.authToken,
    required this.amountCents,
    required this.expiration,
    required this.orderId,
    required this.billingData,
    required this.currency,
    required this.integrationId,
    this.lockOrderWhenPaid = true,
  });

  String authToken;
  @JsonKey(toJson: intToString)
  int amountCents;
  int expiration;
  String orderId;
  BillingData billingData;
  String currency;
  int integrationId;
  @JsonKey(toJson: boolToString)
  bool lockOrderWhenPaid;

  Map<String, dynamic> toJson() => _$PaymentKeyRequestToJson(this);
}

@JsonSerializable(createFactory: false)
class BillingData {
  BillingData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.apartment = NA,
    this.floor = NA,
    this.street = NA,
    this.building = NA,
    this.shippingMethod = NA,
    this.postalCode = NA,
    this.city = NA,
    this.country = NA,
    this.state = NA,
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
  String? shippingMethod;
  @JsonKey(toJson: valueOrNA)
  String? postalCode;
  @JsonKey(toJson: valueOrNA)
  String? city;
  @JsonKey(toJson: valueOrNA)
  String? country;
  @JsonKey(toJson: valueOrNA)
  String? state;

  Map<String, dynamic> toJson() => _$BillingDataToJson(this);
}
