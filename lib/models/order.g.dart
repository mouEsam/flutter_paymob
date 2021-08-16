// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'auth_token': instance.authToken,
      'delivery_needed': instance.deliveryNeeded,
      'amount_cents': instance.amountCents,
      'currency': instance.currency,
      'merchant_order_id': instance.merchantOrderId,
      'items': instance.items,
      'shipping_data': instance.shippingData,
      'shipping_details': instance.shippingDetails,
    };

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'amount_cents': intToNullableString(instance.amountCents),
      'description': instance.description,
      'quantity': instance.quantity,
    };

Map<String, dynamic> _$ShippingDataToJson(ShippingData instance) =>
    <String, dynamic>{
      'apartment': instance.apartment,
      'email': instance.email,
      'floor': instance.floor,
      'first_name': instance.firstName,
      'street': instance.street,
      'building': instance.building,
      'phone_number': instance.phoneNumber,
      'postal_code': instance.postalCode,
      'extra_description': instance.extraDescription,
      'city': instance.city,
      'country': instance.country,
      'last_name': instance.lastName,
      'state': instance.state,
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
