import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'coffee_state.dart';

class CoffeeCubit extends Cubit<CoffeeState> {
  CoffeeCubit(this._coffeeRepository) : super(const CoffeeState());
  final CoffeeRepository _coffeeRepository;

  Future<void> getCoffee() async {
    emit(state.copyWith(status: CoffeeStatus.loading));
    try {
      final image = await _coffeeRepository.getCoffeeImage().timeout(
            const Duration(seconds: 5),
          );
      emit(state.copyWith(status: CoffeeStatus.completed, image: image));
    } catch (e) {
      emit(state.copyWith(status: CoffeeStatus.error, exception: e));
    }
  }
}
