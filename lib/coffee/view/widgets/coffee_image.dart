import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/coffee/coffee.dart';

class CoffeeImage extends StatelessWidget {
  const CoffeeImage({super.key});
  @override
  Widget build(BuildContext context) =>
      context.select((CoffeeCubit cubit) => cubit.state.image);
}
