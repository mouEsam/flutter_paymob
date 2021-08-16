// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'payment_key': instance.paymentKey,
      'save_card_default': instance.saveCardDefault,
      'show_save_card': instance.showSaveCard,
      'theme_color': colorToHex(instance.themeColor),
      'language': localeToLanguage(instance.language),
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
      'apartment': valueOrNA(instance.apartment),
      'floor': valueOrNA(instance.floor),
      'street': valueOrNA(instance.street),
      'building': valueOrNA(instance.building),
      'postal_code': valueOrNA(instance.postalCode),
      'city': valueOrNA(instance.city),
      'country': valueOrNA(instance.country),
      'state': valueOrNA(instance.state),
    };
