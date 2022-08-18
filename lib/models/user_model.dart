import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String id;
  final String name;
  final String username;
  final String password;
  final String avatar;
  final String token;
  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.avatar,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'username': username,
      'password': password,
      'avatar': avatar,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: (map['id'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      username: (map['username'] ?? '') as String,
      password: (map['password'] ?? '') as String,
      avatar: (map['avatar'] ?? '') as String,
      token: (map['token'] ?? '') as String,
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
