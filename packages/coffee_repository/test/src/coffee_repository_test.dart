// ignore_for_file: prefer_const_constructors

import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeApiClient extends Mock implements CoffeeApiClient {}

class MockRandomPath extends Mock implements RandomPath {}

void main() {
  group('CoffeeRepository', () {
    late CoffeeApiClient coffeeApiClient;
    late CoffeeRepository coffeeRepository;

    setUp(() {
      coffeeApiClient = MockCoffeeApiClient();
      coffeeRepository = CoffeeRepository(
        apiClient: coffeeApiClient,
      );
      WidgetsFlutterBinding.ensureInitialized();
    });

    group('getCoffeeImage', () {
      test('calls coffee api ', () async {
        when(() => coffeeApiClient.randomCoffeeUrl()).thenAnswer(
          (_) async => 'https://coffee.alexflipnote.dev/7eAokF8_ro4_coffee.jpg',
        );
        try {
          final actual = await coffeeRepository.getCoffeeImageUrl();
          expect(
            actual,
            'https://coffee.alexflipnote.dev/7eAokF8_ro4_coffee.jpg',
          );
        } catch (_) {}
        verify(() => coffeeApiClient.randomCoffeeUrl()).called(1);
      });
    });
  });
}
