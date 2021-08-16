import 'package:flutter/material.dart';

const String NA = 'NA';

String? intToNullableString(int? value) => value.toString();

String localeToLanguage(Locale? locale) => locale?.languageCode ?? 'en';

String? colorToHex(Color? color) {
  return color == null ? null : '#${color.value.toRadixString(16)}';
}

String valueOrNA(Object? value) => value?.toString() ?? NA;

String boolToString(bool value) => value.toString();

String intToString(int value) => value.toString();
