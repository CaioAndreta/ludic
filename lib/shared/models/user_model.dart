import 'dart:convert';

class UserModel {
  String? id;
  String? name;
  String? email;
  int xp;

  UserModel({
    required this.name,
    required this.email,
    required this.id,
    required this.xp
  });

  factory UserModel.fromMap(Map<String, dynamic>? map) {
    return UserModel(
      id: map!['id'],
      name: map['nome'],
      email: map['email'],
      xp: map['xp'],
    );
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        'id': id,
        'nome': name,
        'email': email,
        'xp': xp,
      };
  String toJson() => jsonEncode(toMap());
}
