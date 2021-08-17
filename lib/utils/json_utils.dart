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

int stringToInt(String? data) =>
    (data == null ? null : int.tryParse(data)) ?? 0;

bool? stringToNullableBool(String? data) {
  switch (data) {
    case "true":
      return true;
    case "false":
      return false;
    default:
      return null;
  }
}

bool stringToBool(String? data) => stringToNullableBool(data) ?? false;
