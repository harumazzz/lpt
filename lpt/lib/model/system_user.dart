// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SystemUser extends Equatable {
  const SystemUser({
    required this.email,
    required this.name,
    required this.birthday,
    required this.gender,
  });

  final String email;
  final String name;
  final String birthday;
  final String gender;

  @override
  List<Object> get props => [email, name, birthday, gender];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'birthday': birthday,
      'gender': gender,
    };
  }

  factory SystemUser.fromMap(Map<String, dynamic> map) {
    return SystemUser(
      email: map['email'] as String,
      name: map['name'] as String,
      birthday: map['birthday'] as String,
      gender: map['gender'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SystemUser.fromJson(String source) =>
      SystemUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
