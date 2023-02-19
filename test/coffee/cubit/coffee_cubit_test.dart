import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/coffee/coffee.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  group('CoffeeCubit', () {
    late CoffeeRepository coffeeRepository;
    late CoffeeCubit coffeeCubit;

    setUp(() async {
      coffeeRepository = MockCoffeeRepository();
      when(
        () => coffeeRepository.getCoffeeImage(),
      ).thenAnswer((_) async =>
          const Image(image: AssetImage('assets/images/placeholder.png')));
      coffeeCubit = CoffeeCubit(coffeeRepository);
    });

    test('initial state is correct', () {
      final coffeeCubit = CoffeeCubit(coffeeRepository);
      expect(coffeeCubit.state.status, CoffeeStatus.init);
    });

    group('getCoffee', () {
      blocTest<CoffeeCubit, CoffeeState>(
        'calls getCoffeeImage',
        build: () => coffeeCubit,
        act: (cubit) => cubit.getCoffee(),
        verify: (_) {
          verify(() => coffeeRepository.getCoffeeImage()).called(1);
        },
      );

      blocTest<CoffeeCubit, CoffeeState>(
        'emits [loading, error] when getCoffeeImage throws',
        setUp: () {
          when(
            () => coffeeRepository.getCoffeeImage(),
          ).thenThrow(Exception('oops'));
        },
        build: () => coffeeCubit,
        act: (cubit) => cubit.getCoffee(),
        expect: () => <dynamic>[
          const CoffeeState(status: CoffeeStatus.loading),
          isA<CoffeeState>()
              .having((w) => w.status, 'status', CoffeeStatus.error)
              .having((s) => s.exception, 'exception', isNotNull)
              .having(
                (s) => s.exception.toString(),
                'exceptionText',
                'Exception: oops',
              ),
        ],
      );

      blocTest<CoffeeCubit, CoffeeState>(
        'emits [loading, completed] when getCoffe returns an image',
        build: () => coffeeCubit,
        act: (cubit) => cubit.getCoffee(),
        expect: () => <dynamic>[
          const CoffeeState(status: CoffeeStatus.loading),
          isA<CoffeeState>()
              .having((w) => w.status, 'status', CoffeeStatus.completed)
              .having((w) => w.status.isCompleted, 'isCompleted', true)
              .having((w) => w.status.hasError, 'hasError', false)
              .having(
                (w) => w.image,
                'image',
                isA<Image>().having((i) => i.image, 'imageProvider', isNotNull),
              ),
        ],
      );
    });
  });
}
