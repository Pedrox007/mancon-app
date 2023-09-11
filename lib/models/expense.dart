class Expense {
  final int? id;
  final String type;
  final String description;
  final double amountSpent;
  final int owner;

  Expense(
      {this.id,
      required this.type,
      required this.description,
      required this.amountSpent,
      required this.owner});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "type": type,
      "description": description,
      "amount_spent": amountSpent,
      "owner": owner,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map["id"]?.toInt(),
      type: map["type"] ?? "",
      description: map["description"] ?? "",
      amountSpent: map["amount_spent"] ?? 0,
      owner: map["owner"] ?? 0,
    );
  }

  @override
  String toString() {
    return "Expense($type, $amountSpent)";
  }
}
