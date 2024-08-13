import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/domain/model/repository_item.dart';
import 'package:github_search_app/domain/use_case/transcribe_use_case.dart';

import '../../../core/app_result.dart';

part 'repository_event.dart';

part 'repository_state.dart';

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  final SearchRepositoriesUseCase _searchRepositoriesUseCase;
  final GetFavoriteRepositoriesUseCase _getFavoriteRepositoriesUseCase;
  final GetHistoryRepositoriesUseCase _getHistoryRepositoriesUseCase;
  final SaveFavoriteRepositoriesUseCase _saveFavoriteRepositoriesUseCase;
  final SaveHistoryRepositoriesUseCase _saveHistoryRepositoriesUseCase;
  List<RepositoryItem> favoriteList = [];
  List<RepositoryItem> historyList = [];

  RepositoryBloc(
      this._searchRepositoriesUseCase,
      this._getFavoriteRepositoriesUseCase,
      this._getHistoryRepositoriesUseCase,
      this._saveFavoriteRepositoriesUseCase,
      this._saveHistoryRepositoriesUseCase)
      : super(RepositoryInitial()) {
    on<ListRepositories>(_onRepositoryListIn);
    on<NullListRepositories>(_onRepositoryClearIn);
    on<AddBookmarkRepository>(_onToggleFavoriteIn);
    on<FavoriteListRepositories>(_onFavoriteListIn);
    on<UpdateRepository>(_onUpdateListIn);
    on<HistoryListRepositories>(_onHistoryListIn);
    on<HistoryListUpdate>(_onHistoryListUpdateIn);
  }

  Future<void> _onHistoryListIn(
      HistoryListRepositories event, Emitter<RepositoryState> emit) async {
    emit(SearchRepositoriesInProgress());
    favoriteList = _getFavoriteRepositoriesUseCase.execute();
    historyList = _getHistoryRepositoriesUseCase.execute();
    if (favoriteList.isNotEmpty) {
      historyList = updateList(historyList);
    }
    emit(SearchRepositoriesInSuccess(list: historyList, true));
  }

  Future<void> _onHistoryListUpdateIn(
      HistoryListUpdate event, Emitter<RepositoryState> emit) async {
    historyList.removeWhere((repo) => repo.id == event.item.id);
    emit(SearchRepositoriesInSuccess(list: historyList, true));
    await _saveHistoryRepositoriesUseCase.execute(historyList);
  }

  Future<void> _onRepositoryListIn(
      ListRepositories event, Emitter<RepositoryState> emit) async {
    emit(SearchRepositoriesInProgress());
    favoriteList = _getFavoriteRepositoriesUseCase.execute();
    historyList = _getHistoryRepositoriesUseCase.execute();
    if (favoriteList.isNotEmpty) {
      historyList = updateList(historyList);
    }
    final response = await _searchRepositoriesUseCase.execute(
        event.query, event.page, event.page);
    switch (response.status) {
      case Status.SUCCESS:
        List<RepositoryItem> list = (favoriteList.isNotEmpty)
            ? updateList(response.data)
            : response.data;
        emit(SearchRepositoriesInSuccess(list: list, false));
        saveHistory(list);
        break;
      case Status.FAILURE:
        emit(RepositoriesInFailure(
            message: response.message.toString(),
            statusCode: response.codeError ?? 400));
        break;
    }
  }

  Future<void> _onFavoriteListIn(
      FavoriteListRepositories event, Emitter<RepositoryState> emit) async {
    emit(SearchRepositoriesInProgress());
    favoriteList = _getFavoriteRepositoriesUseCase.execute();

    favoriteList
        .map(
          (e) => e.isFavorite = true,
        )
        .toList();
    emit(FavoriteRepositoriesInSuccess(list: favoriteList));
  }

  Future<void> _onRepositoryClearIn(
      NullListRepositories event, Emitter<RepositoryState> emit) async {
    emit(SearchRepositoriesInProgress());
    emit(SearchRepositoriesInSuccess(list: historyList, true));
  }

  List<RepositoryItem> updateList(List<RepositoryItem> list) {
    for (var repo in list) {
      for (var favorites in favoriteList) {
        if (favorites.id == repo.id) {
          repo.isFavorite = true;
        } else {
          repo.isFavorite = false;
        }
      }
    }
    return list;
  }

  void saveFavoriteList(List<RepositoryItem> list) async {
    await _saveFavoriteRepositoriesUseCase.execute(list);
  }

  Future<void> _onToggleFavoriteIn(
      AddBookmarkRepository event, Emitter<RepositoryState> emit) async {
    if (event.item.isFavorite) {
      favoriteList.add(event.item);
    } else {
      favoriteList.removeWhere((element) => element.id == event.item.id);
    }
    await _saveFavoriteRepositoriesUseCase.execute(favoriteList);
    var newList = event.list.map(
      (e) {
        if (event.item.id == e.id) {
          e.isFavorite = event.item.isFavorite;
        }
        return e;
      },
    ).toList();
    if (event.isFavoriteScreen) {
      emit(FavoriteRepositoriesInSuccess(list: favoriteList));
    } else {
      emit(SearchRepositoriesInSuccess(list: newList, event.isHistory));
    }
  }

  Future<void> _onUpdateListIn(
      UpdateRepository event, Emitter<RepositoryState> emit) async {
    emit(SearchRepositoriesInProgress());
    favoriteList = _getFavoriteRepositoriesUseCase.execute();
    emit(SearchRepositoriesInSuccess(
        list: (favoriteList.isNotEmpty) ? updateList(event.list) : event.list,
        event.isHistory));
  }

  void saveHistory(List<RepositoryItem> list) async {
    Set<num?> ids = historyList.map((repo) => repo.id).toSet();

    for (var repo in list) {
      if (!ids.contains(repo.id)) {
        if (historyList.length >= 50) {
          historyList.removeAt(0);
        }
        historyList.add(repo);
        ids.add(repo.id);
      }
    }
    await _saveHistoryRepositoriesUseCase.execute(historyList);
  }
}
