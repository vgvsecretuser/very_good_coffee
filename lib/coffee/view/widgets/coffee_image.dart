import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/coffee/coffee.dart';

class CoffeeImage extends StatelessWidget {
  const CoffeeImage({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<CoffeeCubit, CoffeeState>(
        builder: (context, state) {
          if (state.status.isInit) {
            return const Image(
              image: AssetImage('assets/images/placeholder.png'),
            );
          }
          if (state.status.isLoading) {
            return const CircularProgressIndicator();
          }

          return Image.network(
            state.imageUrl,
            fit: BoxFit.cover,
            frameBuilder: frameBuilder,
            errorBuilder: (context, error, stackTrace) =>
                const Image(image: AssetImage('assets/images/error.png')),
          );
        },
      );

  Widget frameBuilder(
    BuildContext context,
    Widget child,
    int? loadingBuilder,
    __,
  ) {
    if (loadingBuilder == null) {
      return const CircularProgressIndicator();
    }
    return child;
  }
}
