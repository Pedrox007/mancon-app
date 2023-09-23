class Expense {
  final int? id;
  final int typeId;
  final String description;
  final double amountSpent;
  final int owner;

  Expense(
      {this.id,
      required this.typeId,
      required this.description,
      required this.amountSpent,
      required this.owner});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "typeId": typeId,
      "description": description,
      "amount_spent": amountSpent,
      "owner": owner,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map["id"]?.toInt(),
      typeId: map["typeId"],
      description: map["description"],
      amountSpent: map["amount_spent"],
      owner: map["owner"],
    );
  }

  @override
  String toString() {
    return "Expense($typeId, $amountSpent)";
  }
}
