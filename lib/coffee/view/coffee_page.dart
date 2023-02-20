import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:very_good_coffee/coffee/coffee.dart';
import 'package:very_good_coffee/l10n/l10n.dart';

export 'widgets/widgets.dart';

class CoffeePage extends StatelessWidget {
  const CoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoffeeCubit(context.read()),
      child: const CoffeeView(),
    );
  }
}

@visibleForTesting
class CoffeeView extends StatelessWidget {
  /// Private class, visible only for testing.
  @visibleForTesting
  const CoffeeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.coffeeAppBarTitle)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: SingleChildScrollView(child: CoffeeImageLoader()),
          ),
          SizedBox(
            height: 90,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () => context.read<CoffeeCubit>().getCoffee(),
                child: Text(l10n.getImageButton),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
