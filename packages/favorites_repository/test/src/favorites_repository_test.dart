// ignore_for_file: prefer_const_constructors

import 'package:favorites_repository/favorites_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FavoritesRepository', () {
    test('can be instantiated', () {
      expect(FavoritesRepository(), isNotNull);
    });
  });
}
