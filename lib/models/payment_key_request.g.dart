// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_key_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PaymentKeyRequestToJson(PaymentKeyRequest instance) =>
    <String, dynamic>{
      'auth_token': instance.authToken,
      'amount_cents': intToString(instance.amountCents),
      'expiration': instance.expiration,
      'order_id': instance.orderId,
      'billing_data': instance.billingData,
      'currency': instance.currency,
      'integration_id': instance.integrationId,
      'lock_order_when_paid': boolToString(instance.lockOrderWhenPaid),
    };

Map<String, dynamic> _$BillingDataToJson(BillingData instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'apartment': valueOrNA(instance.apartment),
      'floor': valueOrNA(instance.floor),
      'street': valueOrNA(instance.street),
      'building': valueOrNA(instance.building),
      'shipping_method': valueOrNA(instance.shippingMethod),
      'postal_code': valueOrNA(instance.postalCode),
      'city': valueOrNA(instance.city),
      'country': valueOrNA(instance.country),
      'state': valueOrNA(instance.state),
    };
