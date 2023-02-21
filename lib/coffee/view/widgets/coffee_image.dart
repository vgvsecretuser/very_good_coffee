import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/coffee/coffee.dart';

class CoffeeImage extends StatelessWidget {
  const CoffeeImage({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<CoffeeCubit, CoffeeState>(
        listener: (context, state) {
          if (state.status.hasError) {
            final error = state.exception.toString();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status.isInit) {
            return const Image(
              image: AssetImage('assets/images/placeholder.png'),
            );
          }
          if (state.status.isInit) {
            return const Image(
              image: AssetImage('assets/images/placeholder.png'),
            );
          }

          return const _CoffeeImageWithProgressIndicator();
        },
      );
}

class _CoffeeImageWithProgressIndicator extends StatelessWidget {
  const _CoffeeImageWithProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: const [
        CircularProgressIndicator(),
        _FavoriteSelectableImage(),
      ],
    );
  }
}

class _FavoriteSelectableImage extends StatelessWidget {
  const _FavoriteSelectableImage();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoffeeCubit, CoffeeState, String>(
      selector: (state) => state.imageUrl,
      builder: (context, imageUrlState) {
        if (imageUrlState.isNotEmpty) {
          return Image.network(
            imageUrlState,
            fit: BoxFit.cover,
            frameBuilder: frameBuilder,
            errorBuilder: (context, error, stackTrace) {
              return const Image(
                image: AssetImage('assets/images/error.png'),
              );
            },
          );
        }
        return Container();
      },
    );
  }

  Widget frameBuilder(
    BuildContext context,
    Widget child,
    int? loadingBuilder,
    __,
  ) {
    return _VisibilitySelectableImage(
      loadingBuilder: loadingBuilder,
      child: child,
    );
  }
}

class _VisibilitySelectableImage extends StatelessWidget {
  const _VisibilitySelectableImage({
    required this.child,
    this.loadingBuilder,
  });
  final int? loadingBuilder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isImageIsReady(loadingBuilder),
      child: Stack(
        children: [
          child,
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.favorite_border_outlined),
              onPressed: () {},
              iconSize: 25,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
        ],
      ),
    );
  }

  bool isImageIsReady(int? loadingBuilder) => loadingBuilder != null;
}
