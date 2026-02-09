class OrderItemModel {
  final int itemId;          // تم تعديل التسمية لتكون نمط الـ CamelCase
  final int productId;       // تم تعديل التسمية لتكون نمط الـ CamelCase
  final String name;
  final int quantity;
  final String price;
  final double spicy;        // إضافة خاصية التوابل
  final List<int> toppings;  // إضافة خاصية التوابل (مثل إضافات الطعام)
  final List<int> sideOptions; // إضافة خاصية الخيارات الجانبية (مثل الأطباق الجانبية)

  OrderItemModel({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    this.spicy = 0.0,        // تعيين قيمة افتراضية للتوابل
    this.toppings = const [], // قيمة افتراضية للإضافات (قائمة فارغة)
    this.sideOptions = const [], // قيمة افتراضية للخيارات الجانبية (قائمة فارغة)
  });

  // تحويل الـ JSON إلى نموذج Dart
  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      itemId: json['item_id'],
      productId: json['product_id'],
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
      spicy: json['spicy']?.toDouble() ?? 0.0,  // تأكد من التحويل إلى double
      toppings: List<int>.from(json['toppings'] ?? []),
      sideOptions: List<int>.from(json['side_options'] ?? []),
    );
  }
  // تحويل النموذج إلى JSON ليتم إرساله في طلبات API
  Map<String, dynamic> toJson()=> {

      'item_id': itemId,
      'product_id': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
      'spicy': spicy,
      'toppings': toppings,
      'side_options': sideOptions,

  };
}

class OrderModel{
  final int? id;
  final String? totalPrice;
  final List<OrderItemModel>? items;
  OrderModel({required this.id,required this.totalPrice,required this.items});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      totalPrice: json['total_price'] ?? '',
      // تحقق إذا كانت 'items' غير null و هي قائمة
      items: json['items'] != null
          ? List<OrderItemModel>.from(
        json['items'].map((item) => OrderItemModel.fromJson(item)),
      ).toList()
          : [], // إذا كانت null، ارجع قائمة فارغة
    );
  }

  }


