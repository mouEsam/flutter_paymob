import 'package:flutter/material.dart';

const String NA = 'NA';

String? intToNullableString(int? value) => value.toString();

String localeToLanguage(Locale? locale) => locale?.languageCode ?? 'en';

String? colorToHex(Color? color) {
  return color == null ? null : '#${color.value.toRadixString(16)}';
}

int? colorToInt(Color? color) {
  return color?.value;
}

String valueOrNA(Object? value) => value?.toString() ?? NA;

Map<String, dynamic> valueOrEmptyObject(dynamic value) => value?.toJson() ?? {};

String boolToString(bool value) => value.toString();

String intToString(int value) => value.toString();

String? dynamicToString(dynamic data) {
  if (data is String) {
    return data;
  } else if (data is int) {
    return data.toString();
  }
  return null;
}

int stringToInt(String? data) =>
    (data == null ? null : int.tryParse(data)) ?? 0;

int dynamicToInt(dynamic data) {
  if (data is int) {
    return data;
  } else if (data is String) {
    return stringToInt(data);
  } else {
    return 0;
  }
}

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

bool dynamicToBool(dynamic data) {
  if (data is bool) {
    return data;
  } else if (data is String) {
    return stringToBool(data);
  }
  return false;
}

bool? dynamicToNullableBool(dynamic data) {
  if (data is bool) {
    return data;
  } else if (data is String) {
    return stringToNullableBool(data);
  }
  return null;
}

Map<String, dynamic> flattenMap(Map<String, dynamic> map) {
  final newMap = <String, dynamic>{};
  map.forEach((key, value) {
    if (value is Map<String, dynamic>) {
      newMap.addAll(flattenMap(value).map((innerKey, innerValue) {
        final newKey = '$key.$innerKey';
        return MapEntry(newKey, innerValue);
      }));
    } else {
      newMap[key] = value;
    }
  });
  return newMap;
}
