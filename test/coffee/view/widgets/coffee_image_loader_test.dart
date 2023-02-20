import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/coffee/coffee.dart';

import '../../../helpers/helpers.dart';

class MockCoffeeCubit extends MockCubit<CoffeeState> implements CoffeeCubit {}

void main() {
  late CoffeeCubit coffeeCubit;

  setUp(() {
    coffeeCubit = MockCoffeeCubit();
  });

  testWidgets('renders LoagingIndicator', (tester) async {
    when(() => coffeeCubit.state).thenReturn(
      const CoffeeState(
        status: CoffeeStatus.loading,
      ),
    );
    await tester.pumpApp(
      BlocProvider.value(
        value: coffeeCubit,
        child: const CoffeeImageLoader(),
      ),
    );
    expect(find.byType(CoffeeImageLoader), findsOneWidget);
  });

  testWidgets('renders LinearProgressIndicator', (tester) async {
    when(() => coffeeCubit.state).thenReturn(
      const CoffeeState(
        status: CoffeeStatus.loading,
      ),
    );
    await tester.pumpApp(
      BlocProvider.value(
        value: coffeeCubit,
        child: const CoffeeImageLoader(),
      ),
    );
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  testWidgets('do not renders LinearProgressIndicator on init state',
      (tester) async {
    when(() => coffeeCubit.state).thenReturn(
      const CoffeeState(),
    );
    await tester.pumpApp(
      BlocProvider.value(
        value: coffeeCubit,
        child: const CoffeeImageLoader(),
      ),
    );
    expect(find.byType(LinearProgressIndicator), findsNothing);
  });

  testWidgets('do not renders LinearProgressIndicator on error state',
      (tester) async {
    when(() => coffeeCubit.state).thenReturn(
      const CoffeeState(
        status: CoffeeStatus.error,
      ),
    );
    await tester.pumpApp(
      BlocProvider.value(
        value: coffeeCubit,
        child: const CoffeeImageLoader(),
      ),
    );
    expect(find.byType(LinearProgressIndicator), findsNothing);
  });

  testWidgets('do not renders LinearProgressIndicator on completed state',
      (tester) async {
    when(() => coffeeCubit.state).thenReturn(
      const CoffeeState(
        status: CoffeeStatus.completed,
      ),
    );
    await tester.pumpApp(
      BlocProvider.value(
        value: coffeeCubit,
        child: const CoffeeImageLoader(),
      ),
    );
    expect(find.byType(LinearProgressIndicator), findsNothing);
  });
}
