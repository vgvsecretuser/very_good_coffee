import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/coffee/coffee.dart';

class CoffeeImageLoader extends StatelessWidget {
  const CoffeeImageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((CoffeeCubit cubit) => cubit.state.status.isLoading);
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : const CoffeeImage();
  }
}
