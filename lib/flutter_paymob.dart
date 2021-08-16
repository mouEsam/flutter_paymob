import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'models/order.dart';
import 'models/payment.dart';
import 'models/payment_key_request.dart';
import 'models/payment_result.dart';

class FlutterPaymob {
  static const MethodChannel _channel = const MethodChannel('flutter_paymob');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  // The Authentication request is an elementary step you should do before dealing with any of Accept's APIs.
  static Future<String> authenticateRequest(String apiKey) async {
    try {
      http.Response response = await http.post(
          Uri.parse('https://accept.paymob.com/api/auth/tokens'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{"api_key": apiKey}));
      String? token = jsonDecode(response.body)['token'];
      if (token != null) {
        return token;
      } else {
        throw jsonDecode(response.body);
      }
    } catch (e) {
      throw e;
    }
  }

  // At this step, you will register an order to Accept's database, so that you can pay for it later using a transaction.
  static Future<int> registerOrder(Order order) async {
    try {
      http.Response response = await http.post(
          Uri.parse('https://accept.paymob.com/api/ecommerce/orders'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: orderToJson(order));
      int? id = jsonDecode(response.body)['id'];
      if (id != null) {
        return id;
      } else {
        throw jsonDecode(response.body);
      }
    } catch (e) {
      throw e;
    }
  }

  // At this step, you will obtain a payment_key token. This key will be used to authenticate your payment request. It will be also used for verifying your transaction request metadata.
  static Future<String> requestPaymentKey(
      PaymentKeyRequest paymentKeyRequest) async {
    try {
      http.Response response = await http.post(
          Uri.parse('https://accept.paymob.com/api/acceptance/payment_keys'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: paymentKeyRequestToJson(paymentKeyRequest));
      String? token = jsonDecode(response.body)['token'];
      if (token != null) {
        return token;
      } else {
        throw jsonDecode(response.body);
      }
    } catch (e) {
      throw e;
    }
  }

  // card payment

  // start pay activity with no token
  static Future<PaymentResult> startPayActivityNoToken(Payment payment) async {
    try {
      final String result = await _channel.invokeMethod(
          'StartPayActivityNoToken', {"payment": paymentToJson(payment)});
      print(result);
      return paymentResultFromJson(result);
    } on PlatformException catch (e) {
      throw e;
    }
  }

  //start pay activity with token
  static Future<String> startPayActivityToken(Payment payment) async {
    try {
      final String result = await _channel.invokeMethod(
          'StartPayActivityToken', {"payment": paymentToJson(payment)});
      return result;
    } on PlatformException catch (e) {
      throw e;
    }
  }
}
