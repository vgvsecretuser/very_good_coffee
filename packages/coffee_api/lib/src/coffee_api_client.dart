import 'dart:async';
import 'dart:convert';

import 'package:coffee_api/coffee_api.dart';
import 'package:http/http.dart' as http;

/// Exception thrown when random coffee json request fails.
class RandomCoffeeJsonRequestFailure implements Exception {}

/// {@template unexpected_response}
/// Exception thrown when the server returns an unexpected response.
/// {@unexpected_response}
class UnexpectedResponse implements Exception {
  /// {@macro unexpected_response}
  UnexpectedResponse(this.error);

  /// The response returned by the server.
  String error;
}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when weather for provided location is not found.
class WeatherNotFoundFailure implements Exception {}

/// {@template coffee_api}
/// Dart API client for Coffee API
/// {@endtemplate}
class CoffeeApiClient {
  /// {@macro coffee_api}
  CoffeeApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'coffee.alexflipnote.dev';

  final http.Client _httpClient;

  /// Gets a random coffee image `/random.json`.
  Future<String> randomCoffeeUrl() async {
    final request = Uri.https(
      _baseUrl,
      '/random.json',
    );

    final response = await _httpClient.get(request);

    if (response.statusCode != 200) {
      throw RandomCoffeeJsonRequestFailure();
    }

    try {
      final randomImage = RandomPath.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );

      return randomImage.file;
    } catch (error) {
      throw UnexpectedResponse(error.toString());
    }
  }
}
