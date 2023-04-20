import 'package:flutter/material.dart';

@immutable
class User {
  const User({
    required this.name,
    required this.age,
  });

  const User.empty() : this(name: 'Test String', age: 0);

  final String name;
  final int age;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          age == other.age;

  @override
  int get hashCode => super.hashCode ^ name.hashCode ^ age.hashCode;

  @override
  String toString() => '''
User(name: $name, age: $age)
''';
}
