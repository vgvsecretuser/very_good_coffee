import 'package:favorites_repository/favorites_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesIconCubit extends Cubit<bool> {
  FavoritesIconCubit(this._favoritesRepository) : super(false);
  final FavoritesRepository _favoritesRepository;

  Future<void> updateImage(String url) async {
    emit(await _favoritesRepository.isFavorite(url));
  }

  Future<void> removeFavorite(String url) async {
    await _favoritesRepository.remove(url);
    emit(false);
  }

  Future<void> onClicFavoriteIconButton(String url) async {
    await _toogleFavorite(url);
  }

  Future<void> _toogleFavorite(String url) async {
    if (state) {
      await removeFavorite(url);
      emit(false);
    } else {
      await _favoritesRepository.saveLocally(url);
      emit(true);
    }
  }
}
