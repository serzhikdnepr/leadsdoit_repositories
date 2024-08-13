part of 'repository_bloc.dart';

@immutable
sealed class RepositoryEvent {}

class ListRepositories extends RepositoryEvent {
  final String query;
  final int page;
  final int perPage;

  ListRepositories(this.query, {this.page = 0, this.perPage = 15});
}

class NullListRepositories extends RepositoryEvent {}

class FavoriteListRepositories extends RepositoryEvent {}

class AddBookmarkRepository extends RepositoryEvent {
  final RepositoryItem item;
  final List<RepositoryItem> list;
  final bool isFavoriteScreen;
  final bool isHistory;

  AddBookmarkRepository(this.item, this.list, this.isFavoriteScreen, this.isHistory);
}

class UpdateRepository extends RepositoryEvent {
  final List<RepositoryItem> list;
  final bool isHistory;
  UpdateRepository(this.list, this.isHistory);
}
class HistoryListRepositories extends RepositoryEvent {}

class HistoryListUpdate extends RepositoryEvent {
  final RepositoryItem item;

  HistoryListUpdate({required this.item});

}