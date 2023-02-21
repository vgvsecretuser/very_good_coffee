import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:equatable/equatable.dart';

part 'coffee_state.dart';

class CoffeeCubit extends Cubit<CoffeeState> {
  CoffeeCubit(this._coffeeRepository) : super(const CoffeeState());
  final CoffeeRepository _coffeeRepository;

  Future<void> getCoffee() async {
    emit(state.copyWith(status: CoffeeRepositoryStatus.loading));
    try {
      final image = await _coffeeRepository.getCoffeeImageUrl().timeout(
            const Duration(seconds: 5),
          );
      emit(
        state.copyWith(
          status: CoffeeRepositoryStatus.completed,
          imageUrl: image,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: CoffeeRepositoryStatus.error, exception: e));
    }
  }

  void onNetworkImageError(String message) {
    emit(
      state.copyWith(
        status: CoffeeRepositoryStatus.error,
        exception: NetworkImageException(),
      ),
    );
  }
}
