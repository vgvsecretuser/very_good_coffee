import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/coffee/coffee.dart';

class LoadingIndicator extends StatelessWidget with PreferredSizeWidget {
  const LoadingIndicator({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(5);

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((CoffeeCubit cubit) => cubit.state.status.isLoading);
    return isLoading ? const LinearProgressIndicator() : Container();
  }
}
