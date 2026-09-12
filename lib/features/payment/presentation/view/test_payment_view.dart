import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TestPaymentView extends StatefulWidget {
  const TestPaymentView({super.key});

  @override
  State<TestPaymentView> createState() => _TestPaymentViewState();
}

class _TestPaymentViewState extends State<TestPaymentView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(
          'http://192.168.100.9:8000/test-payment',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Payment'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}