import 'dart:convert';

import 'package:disposable_playground/core/utils/typedefs.dart';
import 'package:disposable_playground/src/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.name, required super.age});

  const UserModel.empty() : this(name: 'Test String', age: 0);

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : super(name: map['name'] as String, age: (map['age'] as num).toInt());

  UserModel copyWith({String? name, int? age}) {
    return UserModel(name: name ?? this.name, age: age ?? this.age);
  }

  DataMap toMap() => {
        'name': name,
        'age': age,
      };

  String toJson() => jsonEncode(toMap());
}
