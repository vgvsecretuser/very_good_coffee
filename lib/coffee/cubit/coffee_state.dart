part of 'coffee_cubit.dart';

enum CoffeeStatus {
  init,
  loading,
  error,
  completed,
}

extension CoffeeStatusX on CoffeeStatus {
  bool get isInit => this == CoffeeStatus.init;
  bool get isLoading => this == CoffeeStatus.loading;
  bool get hasError => this == CoffeeStatus.error;
  bool get isCompleted => this == CoffeeStatus.completed;
}

/// The Coffee state to be managed by cubit.
class CoffeeState extends Equatable {
  const CoffeeState({
    this.status = CoffeeStatus.init,
    this.exception,
    this.image =
        const Image(image: AssetImage('assets/images/placeholder.png')),
  });
  final CoffeeStatus status;
  final Image image;
  final Object? exception;

  CoffeeState copyWith({
    CoffeeStatus? status,
    Object? exception,
    Image? image,
  }) {
    return CoffeeState(
      status: status ?? this.status,
      image: image ?? this.image,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [status, exception, image];
}
