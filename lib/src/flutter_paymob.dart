import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paymob/src/pages/payment_page_web_no_post.dart';
import 'package:http/http.dart' as http;

import 'models/capture_request.dart';
import 'models/order.dart';
import 'models/payment.dart';
import 'models/payment_key_request.dart';
import 'models/payment_result.dart';
import 'models/refund_request.dart';
import 'pages/payment_page.dart';

class FlutterPaymob {
  static const BASE_URL = 'https://accept.paymob.com/api';
  static const MethodChannel _channel = const MethodChannel('flutter_paymob');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  // The Authentication request is an elementary step you should do before dealing with any of Accept's APIs.
  static Future<String> authenticateRequest(String apiKey) async {
    try {
      http.Response response =
          await http.post(Uri.parse('$BASE_URL/auth/tokens'),
              headers: <String, String>{
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=UTF-8',
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
      http.Response response =
          await http.post(Uri.parse('$BASE_URL/ecommerce/orders'),
              headers: <String, String>{
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=UTF-8',
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
      http.Response response =
          await http.post(Uri.parse('$BASE_URL/acceptance/payment_keys'),
              headers: <String, String>{
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=UTF-8',
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

  static Future<PaymentResult> captureTransaction(
      CaptureRequest captureRequest) async {
    try {
      http.Response response =
          await http.post(Uri.parse('$BASE_URL/acceptance/capture'),
              headers: <String, String>{
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=UTF-8',
              },
              body: captureRequestToJson(captureRequest));
      // final responseBody = jsonDecode(response.body);
      // final success = stringToBool(responseBody['success']) &&
      //     stringToBool(responseBody['is_capture']);
      // return success;
      final paymentResult = paymentResultFromJson(response.body);
      return paymentResult;
    } catch (e) {
      throw e;
    }
  }

  static Future<PaymentResult> refundTransaction(
      RefundRequest refundRequest) async {
    try {
      http.Response response =
          await http.post(Uri.parse('$BASE_URL/acceptance/void_refund/refund'),
              headers: <String, String>{
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=UTF-8',
              },
              body: refundRequestToJson(refundRequest));
      // final responseBody = jsonDecode(response.body);
      // final success = stringToBool(responseBody['success']);
      // return success;
      final paymentResult = paymentResultFromJson(response.body);
      return paymentResult;
    } catch (e) {
      throw e;
    }
  }

  static Future<PaymentResult?> retrieveTransactionById(
      String authToken, String transactionId) async {
    try {
      http.Response response = await http.get(
          Uri.parse('$BASE_URL/acceptance/transactions/$transactionId'),
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: 'Bearer $authToken'
          });
      final body = response.body;
      print("retrieveTransaction $body");
      if (body.contains('Not found')) {
        return null;
      }
      final paymentResult = paymentResultFromJson(body);
      return paymentResult;
    } catch (e, s) {
      print(e);
      print(s);
      throw e;
    }
  }

  static Future<PaymentResult?> retrieveTransaction(String authToken,
      {String? merchantOrderId, String? orderId}) async {
    try {
      final json = {
        "auth_token": authToken,
        if (merchantOrderId != null) "merchant_order_id": merchantOrderId,
        if (orderId != null) "order_id": orderId,
      };
      http.Response response = await http.post(
        Uri.parse(
            'https://accept.paymobsolutions.com/api/ecommerce/orders/transaction_inquiry'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        },
        body: jsonEncode(json),
      );
      final body = response.body;
      print("retrieveTransaction $body");
      if (body.contains('Not found')) {
        return null;
      }
      final paymentResult = paymentResultFromJson(body);
      return paymentResult;
    } catch (e, s) {
      print(e);
      print(s);
      throw e;
    }
  }

  // card payment

  // start pay activity with no token
  static Future<PaymentResult> startPayActivityNoToken(Payment payment) async {
    try {
      final String result = await _channel.invokeMethod(
          'StartPayActivityNoToken', {"payment": paymentToJson(payment)});
      return paymentResultFromFlatJson(result);
    } on PlatformException catch (e) {
      throw e;
    }
  }

  //start pay activity with token
  static Future<PaymentResult> startPayActivityToken(Payment payment) async {
    try {
      final String result = await _channel.invokeMethod(
          'StartPayActivityToken', {"payment": paymentToJson(payment)});
      return paymentResultFromFlatJson(result);
    } on PlatformException catch (e) {
      throw e;
    }
  }

  static Future<PaymentResult?> startPayPage(
      BuildContext context, String paymentKey, String frameId,
      {String? title, Duration popDelay = Duration.zero}) async {
    final nullableResult =
        await PaymentPage.push(context, paymentKey, frameId, title, popDelay);
    return nullableResult;
  }

  static Future<PaymentResult?> startPayPageNoUrlPost(BuildContext context,
      String authKey, String paymentKey, String orderId, String frameId,
      [String? title]) async {
    final nullableResult = await PaymentPageWithNoUrlPost.push(
        context, authKey, paymentKey, orderId, frameId, title);
    return nullableResult;
  }

  static Future<PaymentResult> startPay(
      BuildContext context, Payment payment, String frameId) async {
    try {
      PaymentResult result;
      if (Platform.isAndroid) {
        result = await startPayActivityNoToken(payment);
      } else {
        final nullableResult = await PaymentPage.push(
            context, payment.paymentKey, frameId, null, Duration.zero);
        if (nullableResult == null) {
          throw PlatformException(code: 'USER_CANCELED');
        }
        result = nullableResult;
      }
      return result;
    } on PlatformException catch (e) {
      throw e;
    }
  }
}
