import 'package:get_it/get_it.dart';
import 'package:github_search_app/data/local/app_local_data_source.dart';
import 'package:github_search_app/ui/bloc/repository_bloc/repository_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/http_manager/app_http_manager.dart';
import '../data/http_manager/http_manager.dart';
import '../data/local/local_data_source.dart';
import '../data/remote/app_remote_data_source.dart';
import '../data/remote/remote_data_source.dart';
import '../data/repository/app_repository.dart';
import '../data/service/app_remote_service.dart';
import '../data/service/remote_service.dart';
import '../data/storage/app_storage.dart';
import '../data/storage/storage.dart';
import '../domain/repository/repository.dart';
import '../domain/use_case/transcribe_use_case.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> setupLocator() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<SharedPreferences>(preferences);

  serviceLocator.registerSingleton<Repository>(AppRepository());

  serviceLocator.registerLazySingleton<HttpManager>(() => AppHttpManager());
  serviceLocator
      .registerLazySingleton<RemoteDataSource>(() => AppRemoteDataSource());

  serviceLocator.registerLazySingleton<RemoteService>(() => AppRemoteService());

  serviceLocator.registerLazySingleton<LocalDataSource>(() => AppLocalDataSource());

  serviceLocator.registerLazySingleton<Storage>(() => AppStorage());

  serviceLocator.registerLazySingleton<RepositoryBloc>(() => RepositoryBloc(
    serviceLocator.get(),serviceLocator.get(),serviceLocator.get(),serviceLocator.get(),serviceLocator.get()
  ));

  serviceLocator.registerFactory<SearchRepositoriesUseCase>(
          () => SearchRepositoriesRequest(
        serviceLocator.get(),
      ));

  serviceLocator.registerFactory<GetFavoriteRepositoriesUseCase>(
          () => GetFavoriteRepositoriesRequest(
        serviceLocator.get(),
      ));
  serviceLocator.registerFactory<GetHistoryRepositoriesUseCase>(
          () => GetHistoryRepositoriesRequest(
        serviceLocator.get(),
      ));
  serviceLocator.registerFactory<SaveFavoriteRepositoriesUseCase>(
          () => SaveFavoriteRepositoriesRequest(
        serviceLocator.get(),
      ));
  serviceLocator.registerFactory<SaveHistoryRepositoriesUseCase>(
          () => SaveHistoryRepositoriesRequest(
        serviceLocator.get(),
      ));
}
