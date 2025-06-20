class EquipmentModel {
  final int quantity;
  final double cost;
  final String currency;
  final int equipmentTypeId;

  EquipmentModel({
    required this.quantity,
    required this.cost,
    required this.currency,
    required this.equipmentTypeId,
  });

  factory EquipmentModel.fromJson(Map<String, dynamic> json) {
    return EquipmentModel(
      quantity: json['Quantity'],
      cost: json['Cost'].toDouble(),
      currency: json['Currency'],
      equipmentTypeId: json['EQUIPMENT_TYPE']['Id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "quantity": quantity,
      "cost": cost,
      "currency": currency,
      "equipmentTypeId": equipmentTypeId,
    };
  }
}
