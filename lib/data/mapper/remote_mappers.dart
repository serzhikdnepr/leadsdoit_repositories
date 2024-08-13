

import '../../domain/model/repository_item.dart';
import '../response/search_repository_response.dart';

List<RepositoryItem> mapToRepositoryList(
    SearchRepositoryResponse searchRepositoryResponse) {
  return searchRepositoryResponse.repositories??[];
}