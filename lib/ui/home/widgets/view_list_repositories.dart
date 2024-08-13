import 'package:flutter/material.dart';
import 'package:github_search_app/ui/home/widgets/view_repository.dart';

import '../../../domain/model/repository_item.dart';
import '../../../utils/app_utils.dart';

class RepositoriesList extends StatelessWidget {
  final List<RepositoryItem> repositories;
  final Function(RepositoryItem item) clickFavoriteBtn;
  final Function(RepositoryItem item)? deleteHistory;
  final bool isDismissible;

  const RepositoriesList(
      {super.key,
      required this.repositories,
      required this.clickFavoriteBtn,
      this.deleteHistory,
      required this.isDismissible});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: repositories.length,
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var repository = repositories[index];
        return RepositoryItemView(
          repositoryItem: repository,
          deleteHistory: deleteHistory,
          isDismissible: isDismissible,
          isFavorite: repository.isFavorite,
          clickFavoriteBtn: (bool isFavorite) {
            if (!AppUtils.isFastDoubleClick()) {
              repository.isFavorite = isFavorite;
              clickFavoriteBtn(repository);
            }
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: Colors.transparent,
          height: 8,
          thickness: 8,
        );
      },
    );
  }
}
