class Expense {
  final int? id;
  final int typeId;
  final String description;
  final double quantity;
  final double unitPrice;
  final double shippingPrice;
  double? totalPrice;
  final int owner;

  Expense(
      {this.id,
      required this.typeId,
      required this.description,
      required this.owner,
      required this.quantity,
      required this.unitPrice,
      this.shippingPrice = 0.0,
      this.totalPrice}) {
    totalPrice = (quantity * unitPrice) + shippingPrice;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "type_id": typeId,
      "description": description,
      "quantity": quantity,
      "unit_price": unitPrice,
      "shipping_price": shippingPrice,
      "total_price": totalPrice,
      "owner": owner,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map["id"]?.toInt(),
      typeId: map["type_id"],
      description: map["description"],
      totalPrice: map["total_price"],
      owner: map["owner"],
      quantity: map["quantity"],
      unitPrice: map["unit_price"],
      shippingPrice: map["shipping_price"] ?? 0.0,
    );
  }

  @override
  String toString() {
    return "Expense(id:$id, typeId:$typeId, totalPrice:$totalPrice)";
  }
}
