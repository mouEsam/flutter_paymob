// To parse this JSON data, do
//
//     final paymentKeyRequest = paymentKeyRequestFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'payment_result.g.dart';

PaymentResult paymentResultFromJson(String str) =>
    PaymentResult.fromJson(json.decode(str));

@JsonSerializable(createToJson: false)
class PaymentResult {
  PaymentResult({
    this.dataMessage,
    this.token,
    this.maskedPan,
  });

  final String? dataMessage;
  final String? token;
  final String? maskedPan;

  factory PaymentResult.fromJson(Map<String, dynamic> json) =>
      _$PaymentResultFromJson(json);
}
