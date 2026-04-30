import 'dart:developer';

import 'package:hungry/features/home/data/model/option_model.dart';

import '../../../product/model/options_model.dart';
class OrderItemModel {
  final int productId;
  final int quantity;
  final double? spicy; // مستوى التوابل
  final Map<String, List<OptionModel>> optionsByType;

  OrderItemModel({
    required this.productId,
    required this.quantity,
    this.spicy,
    required this.optionsByType,
  });

  // From  JSON
  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    final Map<String, List<OptionModel>> optionsMap = {};
    (json['options_by_type'] as Map<String, dynamic>? ?? {}).forEach((key, value) {
      optionsMap[key] = (value as List<dynamic>)
          .map((e) => OptionModel.fromJson(e))
          .toList();
    });

    return OrderItemModel(
      productId: json['product_id'],
      quantity: json['quantity'],
      spicy: double.tryParse(json['spicy'].toString()) ?? 0.0,
      optionsByType: optionsMap,
    );
  }

  // To  JSON
  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "quantity": quantity,
      "spicy": spicy,
      "options_by_type": optionsByType.map(
            (key, value) => MapEntry(
          key,
          value.map((option) => option.toJson()).toList(),
        ),
      ),
    };
  }
}