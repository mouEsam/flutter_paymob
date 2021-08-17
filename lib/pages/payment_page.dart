import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_paymob/models/payment_result.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatelessWidget {
  final String token;
  final String? frameId;

  const PaymentPage({required this.token, this.frameId});

  static Future<PaymentResult?> push(
      BuildContext context, String token, String frameId) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PaymentPage(
              token: token,
              frameId: frameId,
            )));
    return result as PaymentResult?;
  }

  @override
  Widget build(BuildContext context) {
    final frameId = this.frameId ?? 'default';
    final checkoutUrl =
        "https://accept.paymob.com/api/acceptance/iframes/$frameId?payment_token=$token";
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text("PayMob"),
      ),
      body: WebView(
        initialUrl: checkoutUrl,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          print(request.url);
          final uri = Uri.parse(request.url);
          if (uri.path.contains('post_pay')) {
            // if (request.url.contains("txn_response_code=APPROVED")) {
            final queryMap = uri.queryParameters;
            final result = PaymentResult.fromJson(queryMap);
            Navigator.of(context).pop(result);
          }
          // if (request.url.contains(cancelURL)) {
          //   Navigator.of(context).pop();
          // }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
