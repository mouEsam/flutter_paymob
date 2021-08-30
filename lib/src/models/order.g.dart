// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'auth_token': instance.authToken,
      'delivery_needed': boolToString(instance.deliveryNeeded),
      'amount_cents': intToString(instance.amountCents),
      'currency': instance.currency,
      'merchant_order_id': instance.merchantOrderId,
      'items': instance.items,
      'shipping_data': valueOrEmptyObject(instance.shippingData),
      'shipping_details': valueOrEmptyObject(instance.shippingDetails),
    };

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'amount_cents': intToNullableString(instance.amountCents),
      'description': instance.description,
      'quantity': intToNullableString(instance.quantity),
    };

Map<String, dynamic> _$ShippingDataToJson(ShippingData instance) =>
    <String, dynamic>{
      'apartment': valueOrNA(instance.apartment),
      'email': valueOrNA(instance.email),
      'floor': valueOrNA(instance.floor),
      'first_name': valueOrNA(instance.firstName),
      'street': valueOrNA(instance.street),
      'building': valueOrNA(instance.building),
      'phone_number': valueOrNA(instance.phoneNumber),
      'postal_code': valueOrNA(instance.postalCode),
      'extra_description': valueOrNA(instance.extraDescription),
      'city': valueOrNA(instance.city),
      'country': valueOrNA(instance.country),
      'last_name': valueOrNA(instance.lastName),
      'state': valueOrNA(instance.state),
    };

Map<String, dynamic> _$ShippingDetailsToJson(ShippingDetails instance) =>
    <String, dynamic>{
      'notes': instance.notes,
      'number_of_packages': instance.numberOfPackages,
      'weight': instance.weight,
      'weight_unit': instance.weightUnit,
      'length': instance.length,
      'width': instance.width,
      'height': instance.height,
      'contents': instance.contents,
    };
