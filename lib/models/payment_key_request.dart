// To parse this JSON data, do
//
//     final paymentKeyRequest = paymentKeyRequestFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'payment_key_request.g.dart';

const String NA = "NA";

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
  @JsonKey(toJson: _intToString)
  int amountCents;
  int expiration;
  String orderId;
  BillingData billingData;
  String currency;
  int integrationId;
  @JsonKey(toJson: _boolToString)
  bool lockOrderWhenPaid;

  Map<String, dynamic> toJson() => _$PaymentKeyRequestToJson(this);
}

String _boolToString(bool value) => value.toString();

String _intToString(int value) => value.toString();

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
  @JsonKey(toJson: _valueOrNA)
  String? apartment;
  @JsonKey(toJson: _valueOrNA)
  String? floor;
  @JsonKey(toJson: _valueOrNA)
  String? street;
  @JsonKey(toJson: _valueOrNA)
  String? building;
  @JsonKey(toJson: _valueOrNA)
  String? shippingMethod;
  @JsonKey(toJson: _valueOrNA)
  String? postalCode;
  @JsonKey(toJson: _valueOrNA)
  String? city;
  @JsonKey(toJson: _valueOrNA)
  String? country;
  @JsonKey(toJson: _valueOrNA)
  String? state;

  Map<String, dynamic> toJson() => _$BillingDataToJson(this);
}

String _valueOrNA(Object? value) => value?.toString() ?? NA;
