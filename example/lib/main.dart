import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_paymob/flutter_paymob.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String apiKey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SndjbTltYVd4bFgzQnJJam94TURRekxDSmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2libUZ0WlNJNkltbHVhWFJwWVd3aWZRLjI5QThEV0hhUGE4Qlk2R0syRm12NldKM0RqYTdxUGgtcmNjeW5rMU1PRDQ1Ukxqa01xakllU2JNVXJYYS1rLTBFazUxYVBmX3Bad05rVXJIbHQ5SEFn';
  String frameId = '83779';
  String transactionId = '11914sdgsgd551';
  int integrationId = 623660;
  int authAndCaptureIntegrationId = 623760;
  String _auth = '';

  int? _orderId;
  String _paymentKey =
      'ZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6VXhNaUo5LmV5SmxlSEFpT2pFMk5ERXdOakExT1RNc0ltRnRiM1Z1ZEY5alpXNTBjeUk2TlRBd0xDSnBiblJsWjNKaGRHbHZibDlwWkNJNk5qTTBNVElzSW1KcGJHeHBibWRmWkdGMFlTSTZleUptYVhKemRGOXVZVzFsSWpvaVNHRmlhV0lpTENKc1lYTjBYMjVoYldVaU9pSklZV0pwWWlJc0luTjBjbVZsZENJNklrNUJJaXdpWW5WcGJHUnBibWNpT2lKT1FTSXNJbVpzYjI5eUlqb2lUa0VpTENKaGNHRnlkRzFsYm5RaU9pSk9RU0lzSW1OcGRIa2lPaUpPUVNJc0luTjBZWFJsSWpvaVRrRWlMQ0pqYjNWdWRISjVJam9pUlVjaUxDSmxiV0ZwYkNJNkluVnpaWEpBWVhCd0xtTnZiU0lzSW5Cb2IyNWxYMjUxYldKbGNpSTZJaXN5TURFeU16UTFOamM0T1RraUxDSndiM04wWVd4ZlkyOWtaU0k2SWs1Qklpd2laWGgwY21GZlpHVnpZM0pwY0hScGIyNGlPaUpPUVNKOUxDSnZjbVJsY2w5cFpDSTZNamN6T0RBME16Z3NJbXh2WTJ0ZmIzSmtaWEpmZDJobGJsOXdZV2xrSWpwbVlXeHpaU3dpWTNWeWNtVnVZM2tpT2lKRlIxQWlMQ0oxYzJWeVgybGtJam96T1RrM09Td2ljRzFyWDJsd0lqb2lNVGswTGpFMk15NHhNemN1TWpBd0luMC5pVVVFb1ZtUEZRVGtFVG5KN1JXbEdPeFQzUl9Md29FREp2bDVnSVEzdjVpTVVYZDZ5QUVFREJLbVdVcUlEZlhUZ1c0Z294RDhXZmctNnVITnNJLWRaZw==';

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
          deliveryNeeded: false,
          amountCents: 100,
          currency: "EGP",
          merchantOrderId: Random().nextInt(100000).toString(),
          items: [
            Item(
                name: "ASC1515",
                amountCents: 500000,
                description: "Smart Watch",
                quantity: 1),
            Item(
                name: "ERT6565",
                amountCents: 200000,
                description: "Power Bank",
                quantity: 1)
          ],
          shippingData: ShippingData(
              apartment: "803",
              email: "claudette09@exa.com",
              floor: "42",
              firstName: "Ahmed1",
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
          orderId: _orderId.toString(),
          billingData: BillingData(
              apartment: "803",
              email: "claudette09@exa.com",
              floor: "42",
              firstName: "Ahmed2",
              street: "Ethan Land",
              building: "8028",
              phoneNumber: "+86(8)9135210487",
              postalCode: "01898",
              city: "Jaskolskiburgh",
              country: "CR",
              lastName: "Nicolas",
              state: "Utah"),
          currency: "EGP",
          integrationId: integrationId,
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

  Future<void> retrieveTransaction() async {
    try {
      final result = await FlutterPaymob.retrieveTransaction(_auth,
          merchantOrderId: transactionId);
      if (!mounted) return;

      setState(() {
        if (result != null) {
          _result = result.dataMessage;
          _token = result.cardToken;
          _maskedPan = result.maskedPan;
        } else {
          _error = 'Not Found';
        }
      });
    } catch (e, s) {
      print(e);
      print(s);
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
        authToken: _auth,
        orderId: _orderId.toString(),
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

  Future<void> startPayPage(BuildContext context) async {
    try {
      PaymentResult? result = await FlutterPaymob.startPayPageNoUrlPost(
          context, _auth, _paymentKey, _orderId.toString(), frameId);
      if (!mounted) return;

      setState(() {
        if (result != null) {
          _result = result.dataMessage;
          _token = result.cardToken;
          _maskedPan = result.maskedPan;
        } else {
          _result = 'User cancelled';
        }
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
        authToken: _auth,
        orderId: _orderId.toString(),
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
      home: Builder(builder: (context) {
        return Scaffold(
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
                    await retrieveTransaction();
                  },
                  child: Text('retrieveTransaction'),
                ),
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
                ElevatedButton(
                  onPressed: () async {
                    await startPayPage(context);
                  },
                  child: Text('startPayPage'),
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
        );
      }),
    );
  }
}
