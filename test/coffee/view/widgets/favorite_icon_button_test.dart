import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/coffee/coffee.dart';
import 'package:very_good_coffee/favorites/view/widgets/widgets.dart';

import '../../../helpers/helpers.dart';

class MockFavoritesIconCubit extends MockCubit<bool>
    implements FavoritesIconCubit {}

void main() {
  late FavoritesIconCubit favoriteIconCubit;

  setUp(() {
    favoriteIconCubit = MockFavoritesIconCubit();
    when(() => favoriteIconCubit.updateImage(any())).thenAnswer(
      (_) => Future<void>.value(),
    );
  });

  testWidgets('renders FavoriteIconButton', (tester) async {
    when(() => favoriteIconCubit.state).thenReturn(false);
    await tester.pumpApp(
      BlocProvider.value(
        value: favoriteIconCubit,
        child: const Scaffold(body: FavoriteIconButton('anyurl')),
      ),
    );
    expect(find.byType(IconButton), findsOneWidget);
  });

  testWidgets('renders filled icon then is not favorite', (tester) async {
    when(() => favoriteIconCubit.state).thenReturn(true);
    await tester.pumpApp(
      BlocProvider.value(
        value: favoriteIconCubit,
        child: const Scaffold(body: FavoriteIconButton('anyurl')),
      ),
    );
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_outline_outlined), findsNothing);
  });

  testWidgets('renders rounded icon then is not favorite', (tester) async {
    when(() => favoriteIconCubit.state).thenReturn(false);
    await tester.pumpApp(
      BlocProvider.value(
        value: favoriteIconCubit,
        child: const Scaffold(body: FavoriteIconButton('anyurl')),
      ),
    );
    expect(find.byIcon(Icons.favorite), findsNothing);
    expect(find.byIcon(Icons.favorite_outline_outlined), findsOneWidget);
  });
}
