import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:webviewx/webviewx.dart';

import '../models/payment_result.dart';

class PaymentPageWithNoUrlPost extends StatefulWidget {
  final String paymentToken;
  final String authToken;
  final String orderId;
  final String? title;
  final String frameId;

  const PaymentPageWithNoUrlPost._(
      {required this.paymentToken,
      required this.frameId,
      required this.orderId,
      this.title,
      required this.authToken});

  static Future<PaymentResult?> push(BuildContext context, String authToken,
      String paymentToken, String orderId, String frameId,
      [String? title]) async {
    var result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PaymentPageWithNoUrlPost._(
              paymentToken: paymentToken,
              orderId: orderId,
              authToken: authToken,
              frameId: frameId,
              title: title,
            )));
    if (result == null && UniversalPlatform.isWeb) {
      return await PaymentPageWithNoUrlPost._checkTransaction(authToken,
          orderId: orderId);
    }
    return result as PaymentResult?;
  }

  static Future<PaymentResult?> _checkTransaction(String authToken,
      {String? merchantOrderId, String? orderId}) async {
    try {
      final result = await FlutterPaymob.retrieveTransaction(authToken,
          merchantOrderId: merchantOrderId, orderId: orderId);
      if (result != null &&
          (result.pending != true || result.success == true)) {
        return result;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  _PaymentPageWithNoUrlPostState createState() =>
      _PaymentPageWithNoUrlPostState();
}

class _PaymentPageWithNoUrlPostState extends State<PaymentPageWithNoUrlPost> {
  final ValueNotifier<bool> running = ValueNotifier(false);
  final ValueNotifier<bool> isLoading = ValueNotifier(true);
  late WebViewXController webviewController;
  Timer? timer;

  Map<String, dynamic>? _tempResultMap;

  Size get screenSize => MediaQuery.of(context).size;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    webviewController.dispose();
    isLoading.dispose();
    running.dispose();
    super.dispose();
  }

  Future<void> _getIFrameContent() async {
    debugPrint("getIFrameContent");
    try {
      final body =
          await webviewController.callJsMethod('getIFrameContent', ['temp']);
      print("BODY $body");
      processBody(body);
    } catch (e) {}
  }

  bool processBody(body) {
    debugPrint("ProcessBody!");
    try {
      final jsonMap = jsonDecode(body as String) as Map<String, dynamic>?;
      if (jsonMap != null) {
        final redirectionUrl = jsonMap['redirection_url'] as String?;
        if (redirectionUrl != null) {
          _tempResultMap ??= jsonMap;
          final shouldRedirect = shouldRedirectToUrl(redirectionUrl);
          if (shouldRedirect) {
            webviewController.loadContent(redirectionUrl, SourceType.urlBypass);
          }
        }
      }
      return true;
    } catch (e, s) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> _handlePaymobResultBody() async {
    debugPrint('handlePaymobResultBody');
    if (_tempResultMap != null) {
      final result = await PaymentPageWithNoUrlPost._checkTransaction(
          widget.authToken,
          orderId: widget.orderId);
      if (result != null) {
        Navigator.pop(context, result);
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? "PayMob"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          _buildWebViewX(context),
          AnimatedBuilder(
            animation: isLoading,
            child: WebViewAware(child: _buildLoader(context)),
            builder: (context, loader) {
              if (isLoading.value) {
                return loader!;
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoader(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: theme.accentColor.withOpacity(0.5),
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  Widget _buildWebViewX(BuildContext context) {
    final frameId = this.widget.frameId;
    final checkoutUrl =
        "https://accept.paymob.com/api/acceptance/iframes/$frameId?payment_token=${widget.paymentToken}";

    return WebViewX(
      key: const ValueKey('webviewx'),
      initialContent: checkoutUrl,
      initialSourceType: SourceType.urlBypass,
      height: screenSize.height,
      width: screenSize.width,
      onWebViewCreated: (controller) {
        webviewController = controller;
        // setUrl();
        initiateScrape();
      },
      onPageStarted: (src) {
        isLoading.value = true;
        debugPrint('A new page has started loading: $src\n');
      },
      onPageFinished: (src) {
        isLoading.value = false;
        debugPrint('The page has finished loading: $src\n');
        _handlePaymobResultBody();
      },
      jsContent: const {
        EmbeddedJsContent(
          mobileJs: "function getIFrameContent(temp) { return temp; }",
          webJs: """function getIFrameContent(temp) {
                try {
                  const body = document.querySelector("body");
                  const text = body.innerText;
                  return text;
                } catch(err) {
                  console.log(err);
                  return temp;
                }
              }""",
        ),
      },
      webSpecificParams: WebSpecificParams(
        additionalSandboxOptions: const [
          'allow-downloads',
          'allow-forms',
          'allow-modals',
          'allow-scripts',
          'allow-orientation-lock',
          'allow-pointer-lock',
          'allow-popups',
          'allow-popups-to-escape-sandbox',
          'allow-presentation',
          'allow-same-origin',
          'allow-navigation',
          // 'allow-top-navigation',
          // 'allow-top-navigation-by-user-activation',
        ],
        proxyList: [
          ExtractPageSourceBypassProxy(),
          // BridgedBypassProxy(),
          // CodeTabsBypassProxy(),
          // WeCorsAnyWhereProxy(),
        ],
        printDebugInfo: true,
      ),
      mobileSpecificParams: const MobileSpecificParams(
        androidEnableHybridComposition: true,
      ),
      navigationDelegate: (navigation) {
        final url = navigation.content.source;
        if (shouldRedirectToUrl(url)) {
          return NavigationDecision.navigate;
        } else {
          return NavigationDecision.prevent;
        }
      },
    );
  }

  void initiateScrape() {
    if (!UniversalPlatform.isWeb) {
      return;
    }
    timer?.cancel();
    timer = Timer.periodic(Duration(milliseconds: 350), (timer) async {
      if (running.value) return;
      running.value = true;
      _getIFrameContent().whenComplete(() => running.value = false);
    });
  }

  bool shouldRedirectToUrl(String url) {
    print(url);
    final uri = Uri.parse(url);
    if (uri.path.contains('post_pay') || uri.authority.contains('post-pay')) {
      // if (request.url.contains("txn_response_code=APPROVED")) {
      final queryMap = uri.queryParameters;
      final result = PaymentResult.fromJson(queryMap);
      Navigator.of(context).pop(result);
      return false;
    }
    return true;
  }
}

class ExtractPageSourceBypassProxy implements BypassProxy {
  @override
  String buildProxyUrl(String pageUrl) {
    print("ExtractPageSourceBypassProxy url: $pageUrl");
    return pageUrl;
  }

  @override
  String extractPageSource(String responseBody) {
    // final jsonResponse = jsonDecode(responseBody) as Map<String, dynamic>;
    print(
        "ExtractPageSourceBypassProxy Page source: ${responseBody.substring(0, min(responseBody.length, 250))}");
    return responseBody;
  }
}
