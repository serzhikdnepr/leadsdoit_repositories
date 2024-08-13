import 'package:github_search_app/domain/model/repository_item.dart';

abstract class Storage {
  Future<void> saveFavoritesList(List<RepositoryItem> list);

  List<RepositoryItem> getFavoritesList();

  Future<void> saveHistoryList(List<RepositoryItem> list);

  List<RepositoryItem> getHistoryList();
}
