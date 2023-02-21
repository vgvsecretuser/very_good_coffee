part of 'favorites_cubit.dart';

class NetworkImageException implements Exception {}

/// The favorites state to be managed by cubit.
class FavoritesState extends Equatable {
  const FavoritesState({
    this.loading = true,
    this.images = const [],
  });

  final List<FavoriteImage> images;
  final bool loading;

  FavoritesState copyWith({
    bool? loading,
    List<FavoriteImage>? images,
  }) {
    return FavoritesState(
      loading: loading ?? this.loading,
      images: images ?? this.images,
    );
  }

  @override
  List<Object?> get props => [images, loading];
}
