import 'package:coffee_repository/coffee_repository.dart';
import 'package:favorites_repository/favorites_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/coffee/view/coffee_page.dart';
import 'package:very_good_coffee/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({
    required CoffeeRepository coffeeRepository,
    required FavoritesRepository favoritesRepository,
    super.key,
  })  : _coffeeRepository = coffeeRepository,
        _favoritesRepository = favoritesRepository;
  final CoffeeRepository _coffeeRepository;
  final FavoritesRepository _favoritesRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _coffeeRepository,
        ),
        RepositoryProvider.value(
          value: _favoritesRepository,
        ),
      ],
      child: const CoffeeApp(),
    );
  }
}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const CoffeePage(),
    );
  }
}
