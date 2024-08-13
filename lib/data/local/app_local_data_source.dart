

import 'package:github_search_app/domain/model/repository_item.dart';

import '../../di/service_locator.dart';
import '../storage/storage.dart';
import 'local_data_source.dart';

class AppLocalDataSource implements LocalDataSource {
  static final storage = serviceLocator<Storage>();

  @override
  List<RepositoryItem> getFavoritesList() {
    return storage.getFavoritesList(); 
  }

  @override
  List<RepositoryItem> getHistoryList() {
    return storage.getHistoryList();
  }

  @override
  Future<void> saveFavoritesList(List<RepositoryItem> list) async{
    await storage.saveFavoritesList(list);
  }

  @override
  Future<void> saveHistoryList(List<RepositoryItem> list) async{
    await storage.saveHistoryList(list);
  }


}
