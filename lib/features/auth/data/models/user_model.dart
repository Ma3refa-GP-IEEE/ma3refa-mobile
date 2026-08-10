class UserModel {
  final String? token;
  final int? id;
  final String name;
  final String email;
  final String password;
  final int age;
  final String gender;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.age,
    required this.gender,
    this.id,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> userData = json['user'] is Map<String, dynamic>
        ? json['user']
        : json;

    return UserModel(
      id: userData['id'],
      token: json['token'],
      name: userData['name'] ?? '',
      email: userData['email'] ?? '',
      password: userData['password'] ?? '',
      age: userData['age'] ?? 0,
      gender: userData['gender'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'name': name,
      'email': email,
      'password': password,
      'age': age,
      'gender': gender,
    };
  }
}
