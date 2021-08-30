// To parse this JSON data, do
//
//     final CaptureRequest = CaptureRequestFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../utils/json_utils.dart';

part 'capture_request.g.dart';

String captureRequestToJson(CaptureRequest data) => json.encode(data.toJson());

@JsonSerializable(createFactory: false)
class CaptureRequest {
  CaptureRequest({
    required this.authToken,
    required this.amountCents,
    required this.transactionId,
  });

  String authToken;
  String transactionId;
  @JsonKey(toJson: intToString)
  int amountCents;

  Map<String, dynamic> toJson() => _$CaptureRequestToJson(this);
}
