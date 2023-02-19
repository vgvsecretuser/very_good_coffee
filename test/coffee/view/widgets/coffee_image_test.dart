import 'package:bloc_test/bloc_test.dart';
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
  testWidgets('renders CounterImage', (tester) async {
    when(() => coffeeCubit.state).thenReturn(const CoffeeState());
    await tester.pumpApp(
      BlocProvider.value(
        value: coffeeCubit,
        child: const CoffeeImage(),
      ),
    );
    expect(find.byType(CoffeeImage), findsOneWidget);
  });
}
