import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/coffee/coffee.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  group('CoffeeState', () {
    test('return an equal CoffeeState', () {
      const coffeeState = CoffeeState();
      expect(coffeeState, const CoffeeState());
    });

    test('initial status', () {
      const coffeeState = CoffeeState();
      expect(coffeeState, const CoffeeState());
      expect(coffeeState.status.isInit, true);
    });

    test('change the status to loading', () {
      final coffeeState =
          const CoffeeState().copyWith(status: CoffeeStatus.loading);
      expect(coffeeState, const CoffeeState(status: CoffeeStatus.loading));
      expect(coffeeState.status.isLoading, true);
    });

    test('change the status to completed', () {
      final coffeeState =
          const CoffeeState().copyWith(status: CoffeeStatus.completed);
      expect(coffeeState, const CoffeeState(status: CoffeeStatus.completed));
      expect(coffeeState.status.isCompleted, true);
    });

    test('change the status to error', () {
      final coffeeState =
          const CoffeeState().copyWith(status: CoffeeStatus.error);
      expect(coffeeState, const CoffeeState(status: CoffeeStatus.error));
      expect(coffeeState.status.hasError, true);
    });

    test('change the the image', () {
      final coffeeState = const CoffeeState().copyWith(
        exception: Exception('test exception'),
      );
      expect(
        coffeeState.exception.toString(),
        'Exception: test exception',
      );
      expect(coffeeState.status.hasError, false);
    });
  });
}
