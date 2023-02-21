import 'package:bloc_test/bloc_test.dart';
import 'package:favorites_repository/favorites_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/coffee/coffee.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  group('FavoritesIconCubit', () {
    late FavoritesRepository favoritesRepository;
    late FavoritesIconCubit favoriteIconCubit;

    setUp(() async {
      favoritesRepository = MockFavoritesRepository();
      favoriteIconCubit = FavoritesIconCubit(favoritesRepository);
    });

    test('initial state is false', () {
      final coffeeCubit = FavoritesIconCubit(favoritesRepository);
      expect(coffeeCubit.state, false);
    });

    group('updateImage', () {
      blocTest<FavoritesIconCubit, bool>(
        'calls isFavorite to update the image',
        setUp: () {
          when(
            () => favoritesRepository.isFavorite(any()),
          ).thenAnswer((_) => Future.value(true));
        },
        build: () => favoriteIconCubit,
        act: (cubit) => cubit.updateImage('anyurl'),
        verify: (_) {
          verify(() => favoritesRepository.isFavorite('anyurl')).called(1);
        },
      );

      blocTest<FavoritesIconCubit, bool>(
        'emits state true to show if the image is already favorite',
        setUp: () {
          when(
            () => favoritesRepository.isFavorite(any()),
          ).thenAnswer((_) => Future.value(true));
        },
        build: () => favoriteIconCubit,
        act: (cubit) => cubit.updateImage('anyurl'),
        expect: () => <dynamic>[
          true,
        ],
      );

      blocTest<FavoritesIconCubit, bool>(
        'emits state false to show if the image is already favorite',
        setUp: () {
          when(
            () => favoritesRepository.isFavorite(any()),
          ).thenAnswer((_) => Future.value(false));
        },
        build: () => favoriteIconCubit,
        act: (cubit) => cubit.updateImage('anyurl'),
        expect: () => <dynamic>[
          false,
        ],
      );

      blocTest<FavoritesIconCubit, bool>(
        'emits state false after removing',
        setUp: () {
          when(
            () => favoritesRepository.remove(any()),
          ).thenAnswer((_) => Future.value());
        },
        build: () => favoriteIconCubit,
        act: (cubit) => cubit.removeFavorite('anyurl'),
        expect: () => <dynamic>[
          false,
        ],
      );
    });
  });
}
