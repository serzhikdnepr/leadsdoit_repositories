import 'dart:convert';

import 'package:github_search_app/data/storage/storage.dart';
import 'package:github_search_app/domain/model/repository_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/service_locator.dart';

class AppStorage implements Storage {
  static final SharedPreferences _preferences =
      serviceLocator<SharedPreferences>();

  final String _prefFavoriteList = "pref_favorite_list";
  final String _prefHistoryList = "pref_history_list";

  @override
  List<RepositoryItem> getFavoritesList() {
    List<String>? jsonList = _preferences.getStringList(_prefFavoriteList);
    if (jsonList != null) {
      return jsonList
          .map((jsonString) => RepositoryItem.fromJson(jsonDecode(jsonString)))
          .toList();
    }
    return [];
  }

  @override
  Future<void> saveFavoritesList(List<RepositoryItem> list) async {
    await _preferences.setStringList(_prefFavoriteList,
        list.map((repo) => jsonEncode(repo.toJson())).toList());
  }

  @override
  List<RepositoryItem> getHistoryList() {
    List<String>? jsonList = _preferences.getStringList(_prefHistoryList);
    if (jsonList != null) {
      return jsonList
          .map((jsonString) => RepositoryItem.fromJson(jsonDecode(jsonString)))
          .toList();
    }
    return [];
  }

  @override
  Future<void> saveHistoryList(List<RepositoryItem> list) async {
    await _preferences.setStringList(_prefHistoryList,
        list.map((repo) => jsonEncode(repo.toJson())).toList());
  }
}
