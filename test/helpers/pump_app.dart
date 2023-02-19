import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/l10n/l10n.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    final CoffeeRepository coffeeRepository = MockCoffeeRepository();
    return pumpWidget(
      RepositoryProvider.value(
        value: coffeeRepository,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: widget,
        ),
      ),
    );
  }
}
