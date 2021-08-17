// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentResult _$PaymentResultFromJson(Map<String, dynamic> json) {
  return PaymentResult(
    json['data.message'] as String?,
    stringToInt(json['amount_cents'] as String?),
    stringToInt(json['captured_amount'] as String?),
    json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    json['currency'] as String?,
    stringToNullableBool(json['error_occured'] as String?),
    stringToNullableBool(json['has_parent_transaction'] as String?),
    json['hmac'] as String?,
    json['id'] as String?,
    json['integration_id'] as String?,
    stringToNullableBool(json['is_3d_secure'] as String?),
    stringToNullableBool(json['is_auth'] as String?),
    stringToNullableBool(json['is_capture'] as String?),
    stringToNullableBool(json['is_refund'] as String?),
    stringToNullableBool(json['is_refunded'] as String?),
    stringToNullableBool(json['is_standalone_payment'] as String?),
    stringToNullableBool(json['is_void'] as String?),
    stringToNullableBool(json['is_voided'] as String?),
    json['order'] as String?,
    json['owner'] as String?,
    stringToNullableBool(json['pending'] as String?),
    json['profile_id'] as String?,
    stringToInt(json['refunded_amount_cents'] as String?),
    json['source_data.pan'] as String?,
    json['source_data.type'] as String?,
    json['source_data.sub_type'] as String?,
    stringToNullableBool(json['success'] as String?),
    json['txn_response_code'] as String?,
    json['token'] as String?,
    json['masked_pan'] as String?,
    json['email'] as String?,
  );
}
