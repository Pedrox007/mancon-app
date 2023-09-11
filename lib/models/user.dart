class User {
  final int? id;
  final String username;
  final String? firstName;
  final String? lastName;
  final String email;
  final String password;

  User(
      {this.id,
      required this.username,
      this.firstName,
      this.lastName,
      required this.email,
      required this.password});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "password": password,
      "username": username,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["id"]?.toInt(),
      password: map["password"] ?? "",
      username: map["username"] ?? "",
      email: map["email"] ?? "",
      firstName: map["first_name"] ?? "",
      lastName: map["last_name"] ?? "",
    );
  }

  @override
  String toString() {
    return "User($username)";
  }
}
