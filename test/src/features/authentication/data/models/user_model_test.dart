import 'dart:convert';

import 'package:disposable_playground/core/utils/typedefs.dart';
import 'package:disposable_playground/src/features/authentication/data/models/user_model.dart';
import 'package:disposable_playground/src/features/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  test(
    'is a [User]',
    () async {
      expect(tModel, isA<User>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid [User] from the given json',
      () async {
        final json = fixture('user.json');

        final result = UserModel.fromJson(json);

        expect(result, equals(tModel));
      },
    );

    test(
      'should throw [Exception] when the json is incorrect',
          () async {
        final json = jsonEncode({'name': 'Test String'});
        const call = UserModel.fromJson;
        expect(() => call(json), throwsA(isA<TypeError>()));
      },
    );
  });

  group('fromMap', () {
    test(
      'should return a valid [User] from the given map',
          () async {
        final map = jsonDecode(fixture('user.json')) as DataMap;

        final result = UserModel.fromMap(map);

        expect(result, equals(tModel));
      },
    );

    test(
      'should throw [Exception] when the map is incorrect',
          () async {
        final map = {'name': 'Test String'};
        const call = UserModel.fromMap;
        expect(() => call(map), throwsA(isA<TypeError>()));
      },
    );
  });

  group('toJson', () {
    test(
      'should return a valid [JSON]',
      () async {
        final json = jsonEncode({'name': 'Test String', 'age': 0});
        final result = tModel.toJson();
        expect(result, equals(json));
      },
    );
  });

  group('toMap', () {
    test(
      'should return a valid [Map]',
      () async {
        final map = {'name': 'Test String', 'age': 0};
        final result = tModel.toMap();
        expect(result, equals(map));
      },
    );
  });
}
