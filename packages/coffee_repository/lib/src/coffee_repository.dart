import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_api/coffee_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// {@template coffee_repository}
/// Coffee repository
///
/// By default images cached will be kept for 180 days if not used (stalePeriod)
/// and the repository will cache up to 50 images.
/// Specify `baseCacheManager` to use a different cache settings.
/// {@endtemplate}
class CoffeeRepository {
  /// {@macro coffee_repository}
  CoffeeRepository({
    CoffeeApiClient? apiClient,
    BaseCacheManager? baseCacheManager,
  })  : _apiClient = apiClient ?? CoffeeApiClient(),
        _baseCacheManager = baseCacheManager ??
            CacheManager(
              Config(
                'coffee_repository_key',
                stalePeriod: const Duration(days: 180),
                maxNrOfCacheObjects: 50,
              ),
            );

  final CoffeeApiClient _apiClient;
  final BaseCacheManager _baseCacheManager;

  /// Fetch the coffee api and return the coffee [Image]
  /// or a random if [url] is not specified.
  Future<Image> getCoffeeImage({
    String? url,
    bool shouldCache = false,
  }) async {
    final imageUrl = url ?? await _apiClient.randomCoffeeUrl();

    return Image(
      image: _getCoffeeImageProvider(
        imageUrl,
        shouldCache: shouldCache,
      ),
    );
  }

  ImageProvider<Object> _getCoffeeImageProvider(
    String url, {
    bool shouldCache = false,
  }) {
    return shouldCache
        ? CachedNetworkImageProvider(
            url,
            cacheManager: _baseCacheManager,
          ) as ImageProvider
        : NetworkImage(url);
  }
}
