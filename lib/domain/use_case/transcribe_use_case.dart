import '../../core/app_result.dart';
import '../model/repository_item.dart';
import '../repository/repository.dart';

abstract class SearchRepositoriesUseCase {
  Future<AppResult> execute(String text, int page, int perPage);
}

class SearchRepositoriesRequest implements SearchRepositoriesUseCase {
  final Repository repository;

  SearchRepositoriesRequest(
    this.repository,
  );

  @override
  Future<AppResult> execute(String text, int page, int perPage) async {
    final response = await repository.searchRepositories(text, page, perPage);
    switch (response.status) {
      case Status.SUCCESS:
        //  _historyCommonDao.addAll(response.data);
        return AppResult.success(response.data);
      default:
        return AppResult.failure(response.message);
    }
  }
}

abstract class GetFavoriteRepositoriesUseCase {
  List<RepositoryItem> execute();
}

class GetFavoriteRepositoriesRequest implements GetFavoriteRepositoriesUseCase {
  final Repository repository;

  GetFavoriteRepositoriesRequest(this.repository);

  @override
  List<RepositoryItem> execute() {
    return repository.getFavoritesList();
  }
}

abstract class GetHistoryRepositoriesUseCase {
  List<RepositoryItem> execute();
}

class GetHistoryRepositoriesRequest implements GetHistoryRepositoriesUseCase {
  final Repository repository;

  GetHistoryRepositoriesRequest(this.repository);

  @override
  List<RepositoryItem> execute() {
    return repository.getHistoryList();
  }
}

abstract class SaveHistoryRepositoriesUseCase {
  Future<void> execute(List<RepositoryItem> list);
}

class SaveHistoryRepositoriesRequest implements SaveHistoryRepositoriesUseCase {
  final Repository repository;

  SaveHistoryRepositoriesRequest(this.repository);

  @override
  Future<void> execute(List<RepositoryItem> list) async {
    await repository.saveHistoryList(list);
  }
}
abstract class SaveFavoriteRepositoriesUseCase {
  Future<void> execute(List<RepositoryItem> list);
}

class SaveFavoriteRepositoriesRequest implements SaveFavoriteRepositoriesUseCase {
  final Repository repository;

  SaveFavoriteRepositoriesRequest(this.repository);

  @override
  Future<void> execute(List<RepositoryItem> list) async {
    await repository.saveFavoritesList(list);
  }
}