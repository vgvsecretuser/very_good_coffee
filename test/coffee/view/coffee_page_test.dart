import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:very_good_coffee/coffee/coffee.dart';

import '../../helpers/helpers.dart';

class MockCoffeeCubit extends MockCubit<CoffeeState> implements CoffeeCubit {}

void main() {
  late CoffeeCubit coffeeCubit;

  setUp(() {
    coffeeCubit = MockCoffeeCubit();
  });

  testWidgets('renders CoffeePage', (tester) async {
    when(() => coffeeCubit.state).thenReturn(
      const CoffeeState(
        status: CoffeeRepositoryStatus.loading,
      ),
    );
    await tester.pumpApp(const CoffeePage());
    expect(find.byType(CoffeePage), findsOneWidget);
  });

  testWidgets('renders CoffeeView', (tester) async {
    when(() => coffeeCubit.state).thenReturn(
      const CoffeeState(
        status: CoffeeRepositoryStatus.loading,
      ),
    );
    await tester.pumpApp(
      BlocProvider.value(
        value: coffeeCubit,
        child: const CoffeeView(),
      ),
    );
    expect(find.byType(CoffeeView), findsOneWidget);
  });

  testWidgets('renders CircularProgressIndicator', (tester) async {
    when(() => coffeeCubit.state).thenReturn(
      const CoffeeState(
        status: CoffeeRepositoryStatus.loading,
      ),
    );
    await tester.pumpApp(
      BlocProvider.value(
        value: coffeeCubit,
        child: const CoffeeView(),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(CoffeeImage), findsOneWidget);
  });

  testWidgets('renders Image when url is set', (tester) async {
    when(() => coffeeCubit.state).thenReturn(
      const CoffeeState(
        status: CoffeeRepositoryStatus.completed,
        imageUrl: 'anyurl',
      ),
    );
    await mockNetworkImages(() async {
      await tester.pumpApp(
        BlocProvider.value(
          value: coffeeCubit,
          child: const CoffeeView(),
        ),
      );
      expect(find.byType(Image), findsOneWidget);
    });
  });

  testWidgets('do not render Image when url is not set', (tester) async {
    when(() => coffeeCubit.state).thenReturn(
      const CoffeeState(
        status: CoffeeRepositoryStatus.completed,
      ),
    );
    await mockNetworkImages(() async {
      await tester.pumpApp(
        BlocProvider.value(
          value: coffeeCubit,
          child: const CoffeeView(),
        ),
      );
      expect(find.byType(Image), findsNothing);
    });
  });

  testWidgets('renders ElevatedButton', (tester) async {
    when(() => coffeeCubit.state).thenReturn(
      const CoffeeState(
        status: CoffeeRepositoryStatus.loading,
      ),
    );
    await tester.pumpApp(
      BlocProvider.value(
        value: coffeeCubit,
        child: const CoffeeView(),
      ),
    );
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('trigger getCoffee when click on the button', (tester) async {
    when(() => coffeeCubit.state).thenReturn(
      const CoffeeState(),
    );
    when(() => coffeeCubit.getCoffee()).thenAnswer((_) async {});
    await tester.pumpApp(
      BlocProvider.value(
        value: coffeeCubit,
        child: const CoffeeView(),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    verify(() => coffeeCubit.getCoffee()).called(1);
  });
}
