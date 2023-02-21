import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/coffee/coffee.dart';

import '../../../helpers/helpers.dart';

class MockCoffeeCubit extends MockCubit<CoffeeState> implements CoffeeCubit {}

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  late CoffeeCubit coffeeCubit;
  late CoffeeRepository coffeeRepository;

  setUp(() {
    coffeeCubit = MockCoffeeCubit();
    coffeeRepository = MockCoffeeRepository();
  });

  testWidgets('renders CoffeeImage', (tester) async {
    when(() => coffeeCubit.state).thenReturn(const CoffeeState());
    await tester.pumpApp(
      BlocProvider.value(
        value: coffeeCubit,
        child: const CoffeeImage(),
      ),
    );
    expect(find.byType(CoffeeImage), findsOneWidget);
  });

  testWidgets('renders CoffeeImage', (tester) async {
    when(() => coffeeCubit.state).thenReturn(const CoffeeState());
    when(() => coffeeRepository.getCoffeeImageUrl())
        .thenThrow(const CoffeeState());
    await tester.pumpApp(
      BlocProvider.value(
        value: CoffeeCubit(coffeeRepository),
        child: const CoffeeImage(),
      ),
    );
    expect(find.byType(CoffeeImage), findsOneWidget);
  });
}
