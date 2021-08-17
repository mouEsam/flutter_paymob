import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:flutter_paymob/models/order.dart';
import 'package:flutter_paymob/models/payment.dart';
import 'package:flutter_paymob/models/payment_key_request.dart';
import 'package:flutter_paymob/models/payment_result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String apiKey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBMk1qZ3dMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuMFVLTTZLZFNhcExTaWo0MWE5MVJ6UU5fcDJ2bm41ZEYyaG11YlQzb2Y3aVVMV0RTLTFXWjZlRnhSYzRtckxINVFkQkFpckJ3OHNONFEyRUNfamMxOHc=';
  String _auth = '';

  int? _orderId;
  String _paymentKey = '';

  String _error = 'No Error';
  String _unknown = 'Unknown';
  String? _result;
  String? _token;
  String? _maskedPan;

  Future<void> authenticateRequest() async {
    try {
      String result = await FlutterPaymob.authenticateRequest(apiKey);
      if (!mounted) return;

      setState(() {
        _auth = result;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = '$e';
      });
    }
  }

  Future<void> registerOrder() async {
    try {
      int result = await FlutterPaymob.registerOrder(
        Order(
          authToken: _auth,
          deliveryNeeded: "false",
          amountCents: "100",
          currency: "EGP",
          merchantOrderId: 19,
          items: [
            Item(
                name: "ASC1515",
                amountCents: 500000,
                description: "Smart Watch",
                quantity: "1"),
            Item(
                name: "ERT6565",
                amountCents: 200000,
                description: "Power Bank",
                quantity: "1")
          ],
          shippingData: ShippingData(
              apartment: "803",
              email: "claudette09@exa.com",
              floor: "42",
              firstName: "Clifford",
              street: "Ethan Land",
              building: "8028",
              phoneNumber: "+86(8)9135210487",
              postalCode: "01898",
              extraDescription: "8 Ram , 128 Giga",
              city: "Jaskolskiburgh",
              country: "CR",
              lastName: "Nicolas",
              state: "Utah"),
          shippingDetails: ShippingDetails(
              notes: "test",
              numberOfPackages: 1,
              weight: 1,
              weightUnit: "Kilogram",
              length: 1,
              width: 1,
              height: 1,
              contents: "product of some sorts"),
        ),
      );
      if (!mounted) return;

      setState(() {
        _orderId = result;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = '$e';
      });
    }
  }

  Future<void> requestPaymentKey() async {
    try {
      String result = await FlutterPaymob.requestPaymentKey(
        PaymentKeyRequest(
          authToken: _auth,
          amountCents: 100,
          expiration: 3600,
          orderId: _orderId.toString(),
          billingData: BillingData(
              apartment: "803",
              email: "claudette09@exa.com",
              floor: "42",
              firstName: "Clifford",
              street: "Ethan Land",
              building: "8028",
              phoneNumber: "+86(8)9135210487",
              postalCode: "01898",
              city: "Jaskolskiburgh",
              country: "CR",
              lastName: "Nicolas",
              state: "Utah"),
          currency: "EGP",
          integrationId: 273760,
          lockOrderWhenPaid: false,
        ),
      );
      if (!mounted) return;

      setState(() {
        _paymentKey = result;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = '$e';
      });
    }
  }

  Future<void> startPayActivityNoToken() async {
    try {
      PaymentResult result =
          await FlutterPaymob.startPayActivityNoToken(Payment(
        paymentKey: _paymentKey,
        saveCardDefault: false,
        showSaveCard: true,
        themeColor: Color(0xFF002B36),
        language: Locale("ar"),
        actionbar: true,
      ));
      if (!mounted) return;

      setState(() {
        _result = result.dataMessage;
        _token = result.cardToken;
        _maskedPan = result.maskedPan;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = '$e';
      });
    }
  }

  Future<void> startPayActivityToken() async {
    try {
      final result = await FlutterPaymob.startPayActivityToken(Payment(
        paymentKey: _paymentKey,
        saveCardDefault: false,
        showSaveCard: true,
        themeColor: Color(0xFF002B36),
        language: Locale("ar"),
        actionbar: true,
        token: _token,
        maskedPanNumber: _maskedPan,
        customer: Customer(
            firstName: "Eman",
            lastName: "Ahmed",
            phoneNumber: "+201012345678",
            email: "example@gmail.com",
            building: "7",
            floor: "9",
            apartment: "91",
            city: "Alexandria",
            country: "Egypt"),
      ));
      if (!mounted) return;

      setState(() {
        _result = result.dataMessage;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = '$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await authenticateRequest();
                },
                child: Text('Authentication Request'),
              ),
              Text('auth: $_auth'),
              ElevatedButton(
                onPressed: () async {
                  await registerOrder();
                },
                child: Text('Order Registration API'),
              ),
              Text('orderId: $_orderId'),
              ElevatedButton(
                onPressed: () async {
                  await requestPaymentKey();
                },
                child: Text('Payment Key Request'),
              ),
              Text('paymentKey: $_paymentKey'),
              Divider(),
              ElevatedButton(
                onPressed: () async {
                  await startPayActivityNoToken();
                },
                child: Text('startPayActivityNoToken'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await startPayActivityToken();
                },
                child: Text('startPayActivityToken'),
              ),
              Text(
                'error: $_error',
                style: TextStyle(color: Colors.red),
              ),
              Text(
                "TRANSACTION_SUCCESSFUL : ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('result: ${_result ?? _unknown}'),
              Text(
                "TRANSACTION_SUCCESSFUL_CARD_SAVED",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('token: ${_token ?? _unknown}'),
              Text('maskedPan: ${_maskedPan ?? _unknown}'),
            ],
          ),
        ),
      ),
    );
  }
}
