import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_paymob/models/payment_result.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PaymentPage extends StatefulWidget {
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
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late FlutterWebviewPlugin flutterWebviewPlugin;

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin = FlutterWebviewPlugin();
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print(url);
      final uri = Uri.parse(url);
      if (uri.path.contains('post_pay')) {
        // if (request.url.contains("txn_response_code=APPROVED")) {
        final queryMap = uri.queryParameters;
        final result = PaymentResult.fromJson(queryMap);
        flutterWebviewPlugin.close();
        Navigator.of(context).pop(result);
      }
    });
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final frameId = this.widget.frameId ?? 'default';
    final checkoutUrl =
        "https://accept.paymob.com/api/acceptance/iframes/$frameId?payment_token=${widget.token}";
    final theme = Theme.of(context);
    return WebviewScaffold(
      url: checkoutUrl,
      withJavascript: true,
      appBar: AppBar(
        title: Text("PayMob"),
      ),
      initialChild: Container(
        color: Colors.redAccent,
        child: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
