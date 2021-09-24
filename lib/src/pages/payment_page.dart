import 'dart:core';

import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

import '../models/payment_result.dart';

class PaymentPage extends StatefulWidget {
  final String token;
  final String? title;
  final String frameId;

  const PaymentPage._({required this.token, required this.frameId, this.title});

  static Future<PaymentResult?> push(
      BuildContext context, String token, String frameId,
      [String? title]) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PaymentPage._(
              token: token,
              frameId: frameId,
              title: title,
            )));
    return result as PaymentResult?;
  }

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isLoading = true;
  late final WebViewXController webviewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    webviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final frameId = this.widget.frameId;
    final checkoutUrl =
        "https://accept.paymob.com/api/acceptance/iframes/$frameId?payment_token=${widget.token}";
    return Scaffold(
      appBar: AppBar(
        foregroundColor: theme.primaryColor,
        backgroundColor: theme.accentColor,
        title: Text(widget.title ?? "PayMob"),
        centerTitle: true,
      ),
      body: _buildWebViewX(context, checkoutUrl),
    );
  }

  Widget _buildLoader(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: theme.accentColor.withOpacity(0.5),
      child: Center(
        child: Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: theme.primaryColor,
            ),
          ),
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }

  Widget _buildWebViewX(BuildContext context, String url) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        WebViewX(
          key: const ValueKey('webviewx'),
          initialContent: url,
          initialSourceType: SourceType.url,
          height: double.infinity,
          width: double.infinity,
          onWebViewCreated: (controller) => webviewController = controller,
          onPageStarted: (src) {
            setState(() {
              isLoading = true;
            });
            debugPrint('A new page has started loading: $src\n');
          },
          onPageFinished: (src) {
            setState(() {
              isLoading = false;
            });
            debugPrint('The page has finished loading: $src\n');
          },
          webSpecificParams: const WebSpecificParams(
            printDebugInfo: true,
          ),
          mobileSpecificParams: const MobileSpecificParams(
            androidEnableHybridComposition: true,
          ),
          navigationDelegate: (navigation) {
            final url = navigation.content.source;
            print(url);
            final uri = Uri.parse(url);
            if (uri.path.contains('post_pay')) {
              // if (request.url.contains("txn_response_code=APPROVED")) {
              final queryMap = uri.queryParameters;
              final result = PaymentResult.fromJson(queryMap);
              Navigator.of(context).pop(result);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
        if (isLoading)
          WebViewAware(
            child: _buildLoader(context),
          ),
      ],
    );
  }
}
