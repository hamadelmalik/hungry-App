import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CheckUrlProductsScreen extends StatefulWidget {
  const CheckUrlProductsScreen({super.key});

  @override
  State<CheckUrlProductsScreen> createState() =>
      _CheckUrlProductsScreenState();
}

class _CheckUrlProductsScreenState
    extends State<CheckUrlProductsScreen> {
  final String baseUrl = 'http://192.168.1.19:8000/api';

  bool isLoading = false;
  List<String> productNames = [];

  /// فحص السيرفر + جلب أسماء المنتجات
  Future<void> checkUrlAndGetProducts() async {
    setState(() {
      isLoading = true;
      productNames.clear();
    });

    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      );

      final response = await dio.get('/products');

      if (response.statusCode == 200 && response.data is List) {
        final List list = response.data;

        productNames =
            list.map((e) => e['name'].toString()).toList();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ السيرفر شغال')),
        );
      } else {
        throw Exception('Invalid response');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ السيرفر غير متاح')),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check URL & Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// عرض الـ URL
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(baseUrl),
            ),

            const SizedBox(height: 16),

            /// زر الفحص
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : checkUrlAndGetProducts,
                child: const Text('Check URL & Load Products'),
              ),
            ),

            const SizedBox(height: 16),

            /// النتيجة
            Expanded(
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : productNames.isEmpty
                  ? const Center(
                child: Text('No products'),
              )
                  : ListView.builder(
                itemCount: productNames.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading:
                      const Icon(Icons.fastfood),
                      title:
                      Text(productNames[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}