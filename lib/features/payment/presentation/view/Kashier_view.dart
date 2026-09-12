import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hungry/features/payment/presentation/view/invoice_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KashierView extends StatefulWidget {
  final String sessionUrl;

  const KashierView({
    super.key,
    required this.sessionUrl,
  });

  @override
  State<KashierView> createState() => _KashierViewState();
}

class _KashierViewState extends State<KashierView> {
  late final WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            log('🔥 PAGE STARTED: $url');
            if (mounted) setState(() => isLoading = true);
          },

          onPageFinished: (url) {
            log('🔥 PAGE FINISHED: $url');
            if (mounted) setState(() => isLoading = false);
          },

          onWebResourceError: (error) {
            log('🔥 WEBVIEW ERROR: ${error.description}');
          },

          onNavigationRequest: (request) {
            log('🔥 NAVIGATION: ${request.url}');

            if (request.url.contains('/payment-success')) {
              final uri = Uri.parse(request.url);
              final orderId = int.tryParse(uri.queryParameters['order_id'] ?? '');

              if (orderId != null) {
                log('🎉 PAYMENT SUCCESS - ORDER ID: $orderId');

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InvoiceView(orderId: orderId),
                  ),
                );
              }

              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.sessionUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Web')),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),

          if (isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
