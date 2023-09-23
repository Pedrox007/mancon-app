class ExpenseType {
  final int? id;
  final String name;
  final String imageName;

  ExpenseType({this.id, required this.name, required this.imageName});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "imageLogo": imageName,
    };
  }

  factory ExpenseType.fromMap(Map<String, dynamic> map) {
    return ExpenseType(
      id: map["id"]?.toInt(),
      name: map["name"] ?? "",
      imageName: map["image_name"] ?? "",
    );
  }

  @override
  String toString() {
    return "Expense($id, $name)";
  }
}
