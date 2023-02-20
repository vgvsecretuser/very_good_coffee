import 'package:coffee_api/coffee_api.dart';

/// {@template coffee_repository}
/// Coffee repository
///
/// Returns de image url
/// {@endtemplate}
class CoffeeRepository {
  /// {@macro coffee_repository}
  CoffeeRepository({
    CoffeeApiClient? apiClient,
  }) : _apiClient = apiClient ?? CoffeeApiClient();

  final CoffeeApiClient _apiClient;

  /// Fetch the coffee api and returns an image url.
  Future<String> getCoffeeImageUrl({
    String? url,
  }) async =>
      _apiClient.randomCoffeeUrl();
}
