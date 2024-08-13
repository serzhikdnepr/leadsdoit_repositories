import '../../core/app_result.dart';
import '../model/repository_item.dart';

abstract class Repository {
  Future<AppResult> searchRepositories(String text, int page, int perPage);

  Future<void> saveFavoritesList(List<RepositoryItem> list);

  List<RepositoryItem> getFavoritesList();

  Future<void> saveHistoryList(List<RepositoryItem> list);

  List<RepositoryItem> getHistoryList();
}
