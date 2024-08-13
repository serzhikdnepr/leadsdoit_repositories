import 'package:github_search_app/domain/model/repository_item.dart';

import '../../core/app_result.dart';
import '../../di/service_locator.dart';
import '../../domain/repository/repository.dart';
import '../local/local_data_source.dart';
import '../remote/remote_data_source.dart';

class AppRepository implements Repository {
  static final remoteDataSource = serviceLocator<RemoteDataSource>();
  static final localDataSource = serviceLocator<LocalDataSource>();

  @override
  Future<AppResult> searchRepositories(String text, int page, int perPage) =>
      remoteDataSource.searchRepositories(text, page, perPage);

  @override
  List<RepositoryItem> getFavoritesList() =>
      localDataSource.getFavoritesList();

  @override
  List<RepositoryItem> getHistoryList() =>
      localDataSource.getHistoryList();

  @override
  Future<void> saveFavoritesList(List<RepositoryItem> list) async =>  
      await localDataSource.saveFavoritesList(list);

  @override
  Future<void> saveHistoryList(List<RepositoryItem> list) async =>
      await localDataSource.saveHistoryList(list);
}
