// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../utils/json_utils.dart';

part 'order.g.dart';

String orderToJson(Order data) {
  print(data.deliveryNeeded);
  return json.encode(data.toJson());
}

@JsonSerializable(createFactory: false)
class Order {
  Order({
    required this.authToken,
    required this.deliveryNeeded,
    required this.amountCents,
    required this.currency,
    this.merchantOrderId,
    required this.items,
    this.shippingData,
    this.shippingDetails,
  });

  String authToken;
  @JsonKey(toJson: boolToString)
  bool deliveryNeeded;
  @JsonKey(toJson: intToString)
  int amountCents;
  String currency;
  String? merchantOrderId;
  List<Item> items;
  @JsonKey(toJson: valueOrEmptyObject)
  ShippingData? shippingData;
  @JsonKey(toJson: valueOrEmptyObject)
  ShippingDetails? shippingDetails;

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable(createFactory: false)
class Item {
  Item({
    this.name,
    this.amountCents,
    this.description,
    this.quantity,
  });

  String? name;
  @JsonKey(toJson: intToNullableString)
  int? amountCents;
  String? description;
  @JsonKey(toJson: intToNullableString)
  int? quantity;

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable(createFactory: false)
class ShippingData {
  ShippingData({
    this.apartment,
    this.email,
    this.floor,
    this.firstName,
    this.street,
    this.building,
    this.phoneNumber,
    this.postalCode,
    this.extraDescription,
    this.city,
    this.country,
    this.lastName,
    this.state,
  });

  @JsonKey(toJson: valueOrNA)
  String? apartment;
  @JsonKey(toJson: valueOrNA)
  String? email;
  @JsonKey(toJson: valueOrNA)
  String? floor;
  @JsonKey(toJson: valueOrNA)
  String? firstName;
  @JsonKey(toJson: valueOrNA)
  String? street;
  @JsonKey(toJson: valueOrNA)
  String? building;
  @JsonKey(toJson: valueOrNA)
  String? phoneNumber;
  @JsonKey(toJson: valueOrNA)
  String? postalCode;
  @JsonKey(toJson: valueOrNA)
  String? extraDescription;
  @JsonKey(toJson: valueOrNA)
  String? city;
  @JsonKey(toJson: valueOrNA)
  String? country;
  @JsonKey(toJson: valueOrNA)
  String? lastName;
  @JsonKey(toJson: valueOrNA)
  String? state;

  Map<String, dynamic> toJson() => _$ShippingDataToJson(this);
}

@JsonSerializable(createFactory: false)
class ShippingDetails {
  ShippingDetails({
    this.notes,
    this.numberOfPackages,
    this.weight,
    this.weightUnit,
    this.length,
    this.width,
    this.height,
    this.contents,
  });

  String? notes;
  int? numberOfPackages;
  int? weight;
  String? weightUnit;
  int? length;
  int? width;
  int? height;
  String? contents;

  Map<String, dynamic> toJson() => _$ShippingDetailsToJson(this);
}
