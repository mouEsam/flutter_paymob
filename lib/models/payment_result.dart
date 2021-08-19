// To parse this JSON data, do
//
//     final paymentKeyRequest = paymentKeyRequestFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_paymob/utils/json_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_result.g.dart';

PaymentResult paymentResultFromJson(String str) =>
    PaymentResult.fromJson(flattenMap(json.decode(str)));

PaymentResult paymentResultFromFlatJson(String str) =>
    PaymentResult.fromJson(json.decode(str));

@JsonSerializable(createToJson: false)
class PaymentResult {
  const PaymentResult(
    this.dataMessage,
    this.amountCents,
    this.capturedAmount,
    this.createdAt,
    this.currency,
    this.errorOccured,
    this.hasParentTransaction,
    this.hmac,
    this.id,
    this.integrationId,
    this.is3dSecure,
    this.isAuth,
    this.isCapture,
    this.isRefund,
    this.isRefunded,
    this.isStandalonePayment,
    this.isVoid,
    this.isVoided,
    this.order,
    this.owner,
    this.pending,
    this.profileId,
    this.refundedAmountCents,
    this.pan,
    this.type,
    this.subType,
    this.success,
    this.responseCode,
    this.cardToken,
    this.maskedPan,
    this.email,
  );

  @JsonKey(fromJson: dynamicToInt)
  final int amountCents;
  @JsonKey(fromJson: dynamicToInt)
  final int capturedAmount;
  final DateTime? createdAt;
  final String? currency;
  @JsonKey(name: 'data.message')
  final String? dataMessage;
  @JsonKey(name: 'token')
  final String? cardToken;
  final String? maskedPan;
  final String? email;
  @JsonKey(fromJson: dynamicToNullableBool)
  final bool? errorOccured;
  @JsonKey(fromJson: dynamicToNullableBool)
  final bool? hasParentTransaction;
  final String? hmac;
  @JsonKey(fromJson: dynamicToString)
  final String? id;
  @JsonKey(fromJson: dynamicToString)
  final String? integrationId;
  @JsonKey(name: 'is_3d_secure', fromJson: dynamicToNullableBool)
  final bool? is3dSecure;
  @JsonKey(fromJson: dynamicToNullableBool)
  final bool? isAuth;
  @JsonKey(fromJson: dynamicToNullableBool)
  final bool? isCapture;
  @JsonKey(fromJson: dynamicToNullableBool)
  final bool? isRefund;
  @JsonKey(fromJson: dynamicToNullableBool)
  final bool? isRefunded;
  @JsonKey(fromJson: dynamicToNullableBool)
  final bool? isStandalonePayment;
  @JsonKey(fromJson: dynamicToNullableBool)
  final bool? isVoid;
  @JsonKey(fromJson: dynamicToNullableBool)
  final bool? isVoided;
  final String? order;
  @JsonKey(fromJson: dynamicToString)
  final String? owner;
  @JsonKey(fromJson: dynamicToNullableBool)
  final bool? pending;
  @JsonKey(fromJson: dynamicToString)
  final String? profileId;
  @JsonKey(fromJson: dynamicToInt)
  final int refundedAmountCents;
  @JsonKey(name: 'source_data.pan')
  final String? pan;
  @JsonKey(name: 'source_data.type')
  final String? type;
  @JsonKey(name: 'source_data.sub_type')
  final String? subType;
  @JsonKey(fromJson: dynamicToNullableBool)
  final bool? success;
  @JsonKey(name: 'txn_response_code')
  final String? responseCode;

  factory PaymentResult.fromJson(Map<String, dynamic> json) =>
      _$PaymentResultFromJson(json);
}
