import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/favorites/favorites.dart';
import 'package:very_good_coffee/l10n/l10n.dart';

export 'widgets/widgets.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit(context.read()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.coffeeAppBarTitle),
        ),
        body: const _FavoritesListView(),
      ),
    );
  }
}

typedef RemoveImage = void Function(String url);

class _FavoritesListView extends StatelessWidget {
  const _FavoritesListView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        final RemoveImage removeImage =
            context.read<FavoritesCubit>().removeImage;
        if (state.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.images.isEmpty) {
          return Center(child: Text(context.l10n.emptyState));
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: state.images.length,
          itemBuilder: (context, index) {
            final image = state.images.elementAt(index);
            return GestureDetector(
              child: Image(
                image: FileImage(
                  image.file,
                ),
              ),
              onTap: () => _onTapImage(
                context,
                image,
                removeImage,
              ),
            );
          },
        );
      },
    );
  }

  void _onTapImage(
    BuildContext context,
    FavoriteImage image,
    RemoveImage removeImage,
  ) =>
      Navigator.push(
        context,
        MaterialPageRoute<BlocProvider>(
          builder: (context) => _FavoriteImageDetail(
            removeImage,
            image,
          ),
        ),
      );
}

class _FavoriteImageDetail extends StatelessWidget {
  const _FavoriteImageDetail(this.removeImage, this.image);
  final FavoriteImage image;
  final RemoveImage removeImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          image.url,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () => _onRemove(context, image),
            icon: const Icon(Icons.delete_outline),
          )
        ],
      ),
      body: Center(
        child: Image(
          image: FileImage(
            image.file,
          ),
        ),
      ),
    );
  }

  void _onRemove(BuildContext context, FavoriteImage image) {
    removeImage(image.url);
    Navigator.of(context).pop();
  }
}
