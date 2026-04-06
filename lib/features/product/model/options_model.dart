import 'package:hungry/features/home/data/model/option_model.dart';

class OrderItemModel {
  final int productId;
  final int quantity;
  final double spicy;
  final Map<String, List<OptionModel>> optionsByType;

  OrderItemModel({
    required this.productId,
    required this.quantity,
    required this.spicy,
    required this.optionsByType,
  });

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'quantity': quantity,
    'spicy': spicy,
    'options_by_type': optionsByType.map((key, value) =>
        MapEntry(key, value.map((option) => option.toJson()).toList())),
  };
}