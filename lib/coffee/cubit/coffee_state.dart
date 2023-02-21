part of 'coffee_cubit.dart';

enum CoffeeRepositoryStatus {
  init,
  loading,
  error,
  completed,
}

extension CoffeeStatusX on CoffeeRepositoryStatus {
  bool get isInit => this == CoffeeRepositoryStatus.init;
  bool get isLoading => this == CoffeeRepositoryStatus.loading;
  bool get hasError => this == CoffeeRepositoryStatus.error;
  bool get isCompleted => this == CoffeeRepositoryStatus.completed;
}

class NetworkImageException implements Exception {}

/// The Coffee state to be managed by cubit.
class CoffeeState extends Equatable {
  const CoffeeState({
    this.status = CoffeeRepositoryStatus.init,
    this.exception,
    this.imageUrl = '',
  });
  final CoffeeRepositoryStatus status;
  final String imageUrl;
  final Object? exception;

  CoffeeState copyWith({
    CoffeeRepositoryStatus? status,
    Object? exception,
    String? imageUrl,
  }) {
    return CoffeeState(
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [status, exception, imageUrl];
}
