// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_key_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PaymentKeyRequestToJson(PaymentKeyRequest instance) =>
    <String, dynamic>{
      'auth_token': instance.authToken,
      'amount_cents': _intToString(instance.amountCents),
      'expiration': instance.expiration,
      'order_id': instance.orderId,
      'billing_data': instance.billingData,
      'currency': instance.currency,
      'integration_id': instance.integrationId,
      'lock_order_when_paid': _boolToString(instance.lockOrderWhenPaid),
    };

Map<String, dynamic> _$BillingDataToJson(BillingData instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'apartment': _valueOrNA(instance.apartment),
      'floor': _valueOrNA(instance.floor),
      'street': _valueOrNA(instance.street),
      'building': _valueOrNA(instance.building),
      'shipping_method': _valueOrNA(instance.shippingMethod),
      'postal_code': _valueOrNA(instance.postalCode),
      'city': _valueOrNA(instance.city),
      'country': _valueOrNA(instance.country),
      'state': _valueOrNA(instance.state),
    };
