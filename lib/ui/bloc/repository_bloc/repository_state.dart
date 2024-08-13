part of 'repository_bloc.dart';

@immutable
sealed class RepositoryState {}

final class RepositoryInitial extends RepositoryState {}

class SearchRepositoriesInProgress extends RepositoryState {}

class SearchRepositoriesInSuccess extends RepositoryState {
  final List<RepositoryItem>? list;
  final bool isHistory;

  SearchRepositoriesInSuccess(this.isHistory, {required this.list});
}

class FavoriteRepositoriesInSuccess extends RepositoryState {
  final List<RepositoryItem>? list;

  FavoriteRepositoriesInSuccess({required this.list});
}

class RepositoriesInFailure extends RepositoryState {
  final String message;
  final int statusCode;

  RepositoriesInFailure({required this.statusCode, required this.message});
}
