// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentResult _$PaymentResultFromJson(Map<String, dynamic> json) {
  return PaymentResult(
    json['data.message'] as String?,
    dynamicToInt(json['amount_cents']),
    dynamicToInt(json['captured_amount']),
    json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    json['currency'] as String?,
    dynamicToNullableBool(json['error_occured']),
    dynamicToNullableBool(json['has_parent_transaction']),
    json['hmac'] as String?,
    dynamicToString(json['id']),
    dynamicToString(json['integration_id']),
    dynamicToNullableBool(json['is_3d_secure']),
    dynamicToNullableBool(json['is_auth']),
    dynamicToNullableBool(json['is_capture']),
    dynamicToNullableBool(json['is_refund']),
    dynamicToNullableBool(json['is_refunded']),
    dynamicToNullableBool(json['is_standalone_payment']),
    dynamicToNullableBool(json['is_void']),
    dynamicToNullableBool(json['is_voided']),
    dynamicToString(json['order']),
    dynamicToString(json['owner']),
    dynamicToNullableBool(json['pending']),
    dynamicToString(json['profile_id']),
    dynamicToInt(json['refunded_amount_cents']),
    json['source_data.pan'] as String?,
    json['source_data.type'] as String?,
    json['source_data.sub_type'] as String?,
    dynamicToNullableBool(json['success']),
    json['txn_response_code'] as String?,
    json['token'] as String?,
    json['masked_pan'] as String?,
    json['email'] as String?,
  );
}
