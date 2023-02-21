import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template favorites_repository}
/// Favorites repository
///
/// By default images cached will be kept for 180 days if not used (stalePeriod)
/// and the repository will cache up to 50 images.
/// Specify `cacheManager` to use a different cache settings.
/// {@endtemplate}
class FavoritesRepository {
  /// {@macro favorites_repository}
  FavoritesRepository({BaseCacheManager? cacheManager})
      : _cacheManager = cacheManager ?? _CustomCacheManager();

  /// Download the file and add to cache
  Future<FileInfo> saveLocally(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(url, true);
    return _cacheManager.downloadFile(url);
  }

  /// Check if the image is already cached
  Future<bool> isFavorite(String url) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(url) ?? false;
  }

  /// Remove image from cache
  Future<void> remove(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(url);
    await _cacheManager.removeFile(url);
  }

  /// Get the file from the cache and/or online, depending on availability and age.
  Future<File> getImaage(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(url, true);
    return _cacheManager.getSingleFile(url);
  }

  final BaseCacheManager _cacheManager;
}

class _CustomCacheManager extends CacheManager with ImageCacheManager {
  factory _CustomCacheManager() {
    return _instance;
  }

  _CustomCacheManager._()
      : super(
          Config(
            key,
            stalePeriod: const Duration(days: 180),
            maxNrOfCacheObjects: 50,
          ),
        );
  static const key = 'customCachedManager';

  static final _CustomCacheManager _instance = _CustomCacheManager._();
}
