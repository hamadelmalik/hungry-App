import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/payment/data/models/invoice_item_model.dart';

import 'package:hungry/features/payment/presentation/cubit/invoice_cubit.dart';
import 'package:hungry/features/payment/presentation/cubit/invoice_state.dart';

class InvoiceView extends StatefulWidget {
  const InvoiceView({super.key, required this.orderId});

  final int orderId;

  @override
  State<InvoiceView> createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
  @override
  void initState() {
    super.initState();

    context.read<InvoiceCubit>().getInvoice(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(title: const Text('الفاتورة'), centerTitle: true),

      body: BlocBuilder<InvoiceCubit, InvoiceState>(
        builder: (context, state) {
          // Loading
          if (state is InvoiceLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (state is InvoiceError) {
            return Center(
              child: Text(state.message, textAlign: TextAlign.center),
            );
          }

          // Success
          if (state is InvoiceSuccess) {
            final invoice = state.invoice;

            return Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // =========================
                    // Logo
                    // =========================
                    Center(
                      child: Image.asset(
                        'assets/images/last_logo.png',
                        height: 90,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Center(
                      child: Text(
                        'Real Burger & Pizza',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // =========================
                    // Order Information
                    // =========================
                    Row(
                      children: [
                        Expanded(
                          child: _InfoBox(
                            title: 'رقم الطلب',
                            value: '#${invoice.id}',
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: _InfoBox(title: 'النوع', value: 'تيك أواي'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // _InfoBox(
                    // title: 'التاريخ',
                    // //value: invoice.createdAt,
                    // ),
                    const SizedBox(height: 25),

                    // =========================
                    // Items Header
                    // =========================
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'الكمية',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),

                          Expanded(
                            flex: 3,
                            child: Text(
                              'الصنف',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),

                          Expanded(
                            flex: 2,
                            child: Text(
                              'السعر',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),

                          Expanded(
                            flex: 2,
                            child: Text(
                              'الإجمالي',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // =========================
                    // Items
                    // =========================
                    ...invoice.items.map((item) => _InvoiceItemRow(item: item)),

                    const SizedBox(height: 20),

                    // =========================
                    // Total
                    // =========================
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'إجمالي الفاتورة',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            '${invoice.total.toStringAsFixed(2)} EGP',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    // =========================
                    // Payment Method
                    // =========================
                    _InfoBox(
                      title: 'طريقة الدفع',
                      value: invoice.paymentMethod,
                    ),

                    const SizedBox(height: 30),

                    // =========================
                    // Footer
                    // =========================
                    const Center(
                      child: Text(
                        'تسعدنا زيارتكم',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Center(
                      child: Text(
                        '01202385159 - 01040363002',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }

          // Initial
          return const SizedBox();
        },
      ),
    );
  }
}

// =====================================================
// Info Box
// =====================================================

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 5),

          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// Invoice Item Row
// =====================================================

class _InvoiceItemRow extends StatelessWidget {
  const _InvoiceItemRow({required this.item});

  final InvoiceItemModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          // Quantity
          Expanded(
            flex: 1,
            child: Text(item.quantity.toString(), textAlign: TextAlign.center),
          ),

          // Product Name
          Expanded(
            flex: 3,
            child: Text(
              item.product?.name ?? 'منتج',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Price
          Expanded(
            flex: 2,
            child: Text(
              item.basePrice.toStringAsFixed(2),
              textAlign: TextAlign.center,
            ),
          ),

          // Total
          Expanded(
            flex: 2,
            child: Text(
              item.totalPrice.toStringAsFixed(2),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
