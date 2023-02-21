import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const int _maxNrOfCacheObjects = 50;

/// {@template favorites_repository}
/// Favorites repository
///
/// By default images cached will be kept for 180 days if not used (stalePeriod)
/// and the repository will cache up to 50 images.
/// Specify `cacheManager` to use a different cache settings.
/// {@endtemplate}
class FavoritesRepository {
  /// {@macro favorites_repository}
  FavoritesRepository({
    BaseCacheManager? cacheManager,
    this.sharedPreferences,
  }) : _cacheManager = cacheManager ?? _CustomCacheManager();

  final BaseCacheManager _cacheManager;

  /// The shared preferences instance.
  SharedPreferences? sharedPreferences;

  Future<SharedPreferences> _getPrefs() async =>
      sharedPreferences ?? await SharedPreferences.getInstance();

  /// Download the file and add to cache
  Future<FileInfo> saveLocally(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(url, true);
    return _cacheManager.downloadFile(url);
  }

  /// Max number of items
  int get maxNumberOfItems => _maxNrOfCacheObjects;

  /// Download the file and add to cache
  Future<int> getNumberOfItems() async {
    final prefs = await _getPrefs();
    return prefs.getKeys().length;
  }

  /// Download the file and add to cache
  Future<Set<String>> getAllItems() async {
    final prefs = await _getPrefs();
    return prefs.getKeys();
  }

  /// Check if the image is already cached
  Future<bool> isFavorite(String url) async {
    final prefs = await _getPrefs();
    return prefs.getBool(url) ?? false;
  }

  /// Remove image from cache
  Future<void> remove(String url) async {
    final prefs = await _getPrefs();
    await prefs.remove(url);
    await _cacheManager.removeFile(url);
  }

  /// Get the file from the cache and/or online, depending on availability and age.
  Future<File> getImaage(String url) async {
    final prefs = await _getPrefs();
    await prefs.setBool(url, true);
    return _cacheManager.getSingleFile(url);
  }
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
            maxNrOfCacheObjects: _maxNrOfCacheObjects,
          ),
        );
  static const key = 'customCachedManager';

  static final _CustomCacheManager _instance = _CustomCacheManager._();
}
