import 'dart:convert';

class UserModel {
  String? id;
  String? name;
  String? email;

  UserModel(
      {required this.name,
      required this.email,
      required this.id,});

  factory UserModel.fromMap(Map<String, dynamic>? map) {
    return UserModel(
        name: map!['nome'],
        email: map['email'],
        id: map['id'],);
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
      };
  String toJson() => jsonEncode(toMap());
}
