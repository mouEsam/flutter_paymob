// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'payment_key': instance.paymentKey,
      'save_card_default': instance.saveCardDefault,
      'show_save_card': instance.showSaveCard,
      'theme_color': _colorToHex(instance.themeColor),
      'language': _localeToLanguage(instance.language),
      'actionbar': instance.actionbar,
      'token': instance.token,
      'masked_pan_number': instance.maskedPanNumber,
      'customer': instance.customer,
    };

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'apartment': _valueOrNA(instance.apartment),
      'floor': _valueOrNA(instance.floor),
      'street': _valueOrNA(instance.street),
      'building': _valueOrNA(instance.building),
      'postal_code': _valueOrNA(instance.postalCode),
      'city': _valueOrNA(instance.city),
      'country': _valueOrNA(instance.country),
      'state': _valueOrNA(instance.state),
    };
