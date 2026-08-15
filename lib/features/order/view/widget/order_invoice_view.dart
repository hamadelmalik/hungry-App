import 'package:flutter/material.dart';

class OrderInvoiceView extends StatelessWidget {
  const OrderInvoiceView({
    super.key,
    required this.orderNumber,
    required this.date,
    required this.items,
    required this.total,
    this.paymentMethod = 'cash',
  });

  final int orderNumber;
  final String date;
  final List<InvoiceItem> items;
  final double total;
  final String paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,

          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          title: const Text(
            'الفاتورة',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),

          child: Column(
            children: [

              // =========================
              // Logo
              Image.asset(
                'assets/images/last_logo.png',
                width: 400,
                height: 200,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 10),

              Container(
                width: 120,
                height: 100,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.restaurant,
                  size: 75,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'ريل بيرقر',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'من الشام للمأكولات السورية',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                '52 شارع المحولات - المهندسين - بجوار مستشفى الهرم التخصصي',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone,
                    size: 22,
                    color: Colors.black,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '01202385159 - 01040363002',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // =========================
              // Order information
              // =========================

              Row(
                children: [
                  Expanded(
                    child: _InfoBox(
                      title: 'رقم الطلب',
                      value: orderNumber.toString(),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _InfoBox(
                      title: 'نوع الطلب',
                      value: 'تيك أواي',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              _InfoBox(
                title: 'التاريخ',
                value: date,
                fullWidth: true,
              ),

              const SizedBox(height: 20),

              // =========================
              // Items Header
              // =========================

              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),

                child: Column(
                  children: [

                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),

                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                      ),

                      child: const Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'الكمية',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 5,
                            child: Text(
                              'الصنف',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 2,
                            child: Text(
                              'السعر',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 2,
                            child: Text(
                              'الإجمالي',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // =========================
                    // Items
                    // =========================

                    ...items.map(
                          (item) => _InvoiceItemRow(
                        item: item,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // Total
              // =========================

              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),

                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 14,
                ),

                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      'إجمالي الفاتورة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      '${total.toStringAsFixed(2)} ج.م',
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // Payment
              // =========================

              Text(
                'طريقة الدفع: $paymentMethod',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'تسعدنا زيارتكم',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}


// ======================================================
// Info Box
// ======================================================

class _InfoBox extends StatelessWidget {
  const _InfoBox({
    required this.title,
    required this.value,
    this.fullWidth = false,
  });

  final String title;
  final String value;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,

      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.5,
        ),
      ),

      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),

      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}


// ======================================================
// Invoice Item
// ======================================================

class _InvoiceItemRow extends StatelessWidget {
  const _InvoiceItemRow({
    required this.item,
  });

  final InvoiceItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),

      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 5,
      ),

      child: Row(
        children: [

          Expanded(
            flex: 2,
            child: Text(
              item.quantity.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            flex: 5,
            child: Text(
              item.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              item.price.toStringAsFixed(2),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              item.total.toStringAsFixed(2),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// ======================================================
// Invoice Item Model
// ======================================================

class InvoiceItem {
  final String name;
  final int quantity;
  final double price;
  final double total;

  const InvoiceItem({
    required this.name,
    required this.quantity,
    required this.price,
    required this.total,
  });
}