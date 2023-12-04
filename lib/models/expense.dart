class Expense {
  final int? id;
  final int typeId;
  final String description;
  final double quantity;
  final double unitPrice;
  final double shippingPrice;
  double? totalPrice;
  final int owner;
  final String? voucherFileId;
  final String? voucherFileURL;
  final String? voucherFileType;

  Expense({
    this.id,
    required this.typeId,
    required this.description,
    required this.owner,
    required this.quantity,
    required this.unitPrice,
    this.shippingPrice = 0.0,
    this.totalPrice,
    this.voucherFileId,
    this.voucherFileURL,
    this.voucherFileType,
  }) {
    totalPrice = (quantity * unitPrice) + shippingPrice;
  }

  Map<String, dynamic> toMap() {
    return {
      "type_id": typeId,
      "description": description,
      "quantity": quantity,
      "unit_price": unitPrice,
      "shipping_price": shippingPrice,
      "total_price": totalPrice,
      "owner_id": owner,
      "voucher_file_id": voucherFileId,
      "voucher_file_url": voucherFileURL,
      "voucher_file_type": voucherFileType,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map["id"]?.toInt(),
      typeId: map["type"]["id"],
      description: map["description"],
      totalPrice: map["total_price"],
      owner: map["owner"]["id"],
      quantity: double.parse(map["quantity"]),
      unitPrice: double.parse(map["unit_price"]),
      shippingPrice: double.parse(map["shipping_price"]),
      voucherFileId: map["voucher_file"]?["file_id"],
      voucherFileURL: map["voucher_file"]?["file_url"],
      voucherFileType: map["voucher_file"]?["file_type"],
    );
  }

  @override
  String toString() {
    return "Expense(id:$id, typeId:$typeId, totalPrice:$totalPrice)";
  }
}
