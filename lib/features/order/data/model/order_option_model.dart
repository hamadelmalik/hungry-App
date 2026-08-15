class OrderOptionModel {
  final int optionTypeId;
  final int optionId;
  final double optionPrice;

  OrderOptionModel({
    required this.optionTypeId,
    required this.optionId,
    required this.optionPrice,
  });


  factory OrderOptionModel.fromJson(Map<String, dynamic> json) {
    return OrderOptionModel(
      optionTypeId:
      int.tryParse(json['option_type_id'].toString()) ?? 0,

      optionId:
      int.tryParse(json['option_id'].toString()) ?? 0,

      optionPrice:
      double.tryParse(json['option_price'].toString()) ?? 0,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "option_type_id": optionTypeId,
      "option_id": optionId,
      "option_price": optionPrice,
    };
  }
}