// ignore_for_file: prefer_const_constructors

import 'package:favorites_repository/favorites_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('FavoritesRepository', () {
    late FavoritesRepository favoritesRepository;
    const initialSharedPrefsData = <String, bool>{
      'item1': true,
      'item2': true,
      'item3': true
    };

    setUp(() async {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues(initialSharedPrefsData);
      final pref = await SharedPreferences.getInstance();
      favoritesRepository = FavoritesRepository(sharedPreferences: pref);
    });

    test('can be instantiated', () {
      expect(FavoritesRepository(), isNotNull);
    });

    test('max number of items is 50', () {
      final actual = FavoritesRepository().maxNumberOfItems;
      expect(actual, 50);
    });

    test('the number of items', () async {
      final actual = await favoritesRepository.getNumberOfItems();
      expect(actual, initialSharedPrefsData.length);
    });

    test('the number of items', () async {
      final actual = await favoritesRepository.getAllItems();
      expect(actual.toList(), initialSharedPrefsData.keys.toList());
    });
  });
}
