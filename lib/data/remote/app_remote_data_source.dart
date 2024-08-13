

import 'package:github_search_app/data/remote/remote_data_source.dart';

import '../../core/app_result.dart';
import '../../di/service_locator.dart';
import '../../domain/exceptions/app_exceptions.dart';
import '../mapper/remote_mappers.dart';
import '../response/search_repository_response.dart';
import '../service/remote_service.dart';

class AppRemoteDataSource implements RemoteDataSource {
  static final service = serviceLocator<RemoteService>();

  @override
  Future<AppResult> searchRepositories(
      String text, int page, int perPage) async {
    try {
      final response = SearchRepositoryResponse.fromJson(
          await service.searchRepositories(text, page, perPage));
      return AppResult.success(mapToRepositoryList(response));
    } on AppException catch (error) {
      return AppResult.failure(error.message, error.codeError);
    } catch (e) {
      return AppResult.failure();
    }
  }
}
