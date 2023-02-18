// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeApiClient extends Mock implements CoffeeApiClient {}

class MockRandomPath extends Mock implements RandomPath {}

class MockBaseCacheManager extends Mock implements BaseCacheManager {}

void main() {
  group('CoffeeRepository', () {
    late CoffeeApiClient coffeeApiClient;
    late CoffeeRepository coffeeRepository;

    setUp(() {
      coffeeApiClient = MockCoffeeApiClient();
      coffeeRepository = CoffeeRepository(
        apiClient: coffeeApiClient,
        baseCacheManager: MockBaseCacheManager(),
      );
      WidgetsFlutterBinding.ensureInitialized();
    });

    group('constructor', () {
      test('can be instantiated without apiClient and baseCacheManager', () {
        expect(CoffeeRepository(), isNotNull);
      });
    });

    group('getCoffeeImage', () {
      test('calls coffee api to get the path when url not provided', () async {
        when(() => coffeeApiClient.randomCoffeeUrl()).thenAnswer((_) async =>
            'https://coffee.alexflipnote.dev/7eAokF8_ro4_coffee.jpg');
        try {
          await coffeeRepository.getCoffeeImage();
        } catch (_) {}
        verify(() => coffeeApiClient.randomCoffeeUrl()).called(1);
      });

      test('do not call coffee random path api then when url is provided',
          () async {
        try {
          await coffeeRepository.getCoffeeImage(
              url: 'https://coffee.alexflipnote.dev/7eAokF8_ro4_coffee.jpg');
        } catch (_) {}
        verifyNever(() => coffeeApiClient.randomCoffeeUrl());
      });

      test('use cached image provider when shouldCache is true', () async {
        final actual = await coffeeRepository.getCoffeeImage(
          url: 'https://coffee.alexflipnote.dev/7eAokF8_ro4_coffee123.jpg',
          shouldCache: true,
        );
        expect(
          actual.image,
          isA<CachedNetworkImageProvider>().having((c) => c.url, 'url',
              'https://coffee.alexflipnote.dev/7eAokF8_ro4_coffee123.jpg'),
        );

        verifyNever(() => coffeeApiClient.randomCoffeeUrl());
      });

      test('use cached image provider when shouldCache is false', () async {
        final actual = await coffeeRepository.getCoffeeImage(
          url: 'https://coffee.alexflipnote.dev/7eAokF8_ro4_coffee123.jpg',
        );
        expect(
          actual.image,
          isA<NetworkImage>().having((c) => c.url, 'url',
              'https://coffee.alexflipnote.dev/7eAokF8_ro4_coffee123.jpg'),
        );

        verifyNever(() => coffeeApiClient.randomCoffeeUrl());
      });

      test('throws when coffee api fails', () async {
        final exception = Exception('oops');
        when(() => coffeeApiClient.randomCoffeeUrl()).thenThrow(exception);
        expect(
          () async => coffeeRepository.getCoffeeImage(),
          throwsA(exception),
        );
      });
    });
  });
}
