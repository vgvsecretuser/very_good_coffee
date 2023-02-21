import 'package:coffee_repository/coffee_repository.dart';
import 'package:favorites_repository/favorites_repository.dart';
import 'package:flutter/material.dart';
import 'package:very_good_coffee/app/app.dart';
import 'package:very_good_coffee/bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final coffeeDevelopmentRepository = CoffeeRepository();
  final favoritesRepository = FavoritesRepository();
  bootstrap(
    () => App(
      coffeeRepository: coffeeDevelopmentRepository,
      favoritesRepository: favoritesRepository,
    ),
  );
}
