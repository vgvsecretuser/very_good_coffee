import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/coffee/coffee.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton(
    this.url, {
    super.key,
  });
  final String url;

  @override
  Widget build(BuildContext context) {
    context.watch<FavoritesIconCubit>().updateImage(url);
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: const _IconFilled(),
        onPressed: () =>
            context.read<FavoritesIconCubit>().onClicFavoriteIconButton(url),
        iconSize: 25,
        color: Theme.of(context).secondaryHeaderColor,
      ),
    );
  }
}

class _IconFilled extends StatelessWidget {
  const _IconFilled();

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<FavoritesIconCubit>().state;
    return isFavorite
        ? const Icon(Icons.favorite)
        : const Icon(Icons.favorite_outline_outlined);
  }
}
