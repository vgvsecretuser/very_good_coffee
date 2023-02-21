import 'package:equatable/equatable.dart';
import 'package:favorites_repository/favorites_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/favorites/favorites.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._favoritesRepository) : super(const FavoritesState()) {
    loadData();
  }
  final FavoritesRepository _favoritesRepository;

  Future<void> loadData() async {
    emit(state.copyWith(loading: true));
    final items = await _favoritesRepository.getAllItems();

    final images = await Future.wait(
      items.map(
        (element) async {
          final file = await _favoritesRepository.getImaage(element);
          return FavoriteImage(url: element, file: file);
        },
      ),
    );
    emit(state.copyWith(images: images, loading: false));
  }

  Future<void> removeImage(String url) async {
    final removed = state.images.where((element) => element.url != url);
    await _favoritesRepository.remove(url);
    emit(state.copyWith(images: removed.toList(), loading: false));
  }
}
