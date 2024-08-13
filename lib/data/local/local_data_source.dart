

import '../../domain/model/repository_item.dart';

abstract class LocalDataSource {
  Future<void> saveFavoritesList(List<RepositoryItem> list);

  List<RepositoryItem> getFavoritesList();

  Future<void> saveHistoryList(List<RepositoryItem> list);

  List<RepositoryItem> getHistoryList();
}
