import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:very_good_coffee/app/app.dart';
import 'package:very_good_coffee/bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final coffeeStagingRepository = CoffeeRepository();
  bootstrap(() => App(coffeeRepository: coffeeStagingRepository));
}
