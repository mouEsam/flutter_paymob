// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_paymob/utils/json_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

String orderToJson(Order data) => json.encode(data.toJson());

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
  String deliveryNeeded;
  String amountCents;
  String currency;
  int? merchantOrderId;
  List<Item> items;
  ShippingData? shippingData;
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
  String? quantity;

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

  String? apartment;
  String? email;
  String? floor;
  String? firstName;
  String? street;
  String? building;
  String? phoneNumber;
  String? postalCode;
  String? extraDescription;
  String? city;
  String? country;
  String? lastName;
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
