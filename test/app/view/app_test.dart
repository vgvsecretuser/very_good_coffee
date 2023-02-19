import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee/app/app.dart';
import 'package:very_good_coffee/coffee/view/coffee_page.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(App(
        coffeeRepository: CoffeeRepository(),
      ));
      expect(find.byType(CoffeePage), findsOneWidget);
    });
  });
}
