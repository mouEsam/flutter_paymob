// To parse this JSON data, do
//
//     final RefundRequest = CaptureRequestFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_paymob/utils/json_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refund_request.g.dart';

String refundRequestToJson(RefundRequest data) => json.encode(data.toJson());

@JsonSerializable(createFactory: false)
class RefundRequest {
  RefundRequest({
    required this.authToken,
    required this.amountCents,
    required this.transactionId,
  });

  String authToken;
  String transactionId;
  @JsonKey(toJson: intToString)
  int amountCents;

  Map<String, dynamic> toJson() => _$RefundRequestToJson(this);
}
