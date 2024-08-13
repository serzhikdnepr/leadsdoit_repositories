import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:github_search_app/di/service_locator.dart';
import 'package:github_search_app/ui/home/widgets/search_widget.dart';
import 'package:github_search_app/ui/home/widgets/view_list_repositories.dart';
import 'package:github_search_app/utils/app_utils.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../domain/model/repository_item.dart';
import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../router/router.gr.dart';
import '../../utils/styles.dart';
import '../bloc/repository_bloc/repository_bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List<RepositoryItem>? _repositories;

  var repositoryBloc = serviceLocator<RepositoryBloc>();

  bool isHistory = true;

  @override
  void initState() {
    repositoryBloc.add(HistoryListRepositories());
    super.initState();
  }

  void _onSearchChanged(String query) {
    if (query.length >= 4) {
      _repositories = null;
      repositoryBloc.add(ListRepositories(query));
    } else {
      if (query.isEmpty) {
        repositoryBloc.add(NullListRepositories());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bgPage,
      appBar: AppBar(
        title: Text(
          S.of(context).titleApp,
          style: titleStyle,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(
            height: 3,
            width: double.infinity,
            color: colorDivider,
          ),
        ),
        backgroundColor: bgAppBar,
        centerTitle: true,
        actions: [
          GFIconButton(
            color: GFColors.TRANSPARENT,
            iconSize: (44),
            padding: const EdgeInsets.only(right: (16)),
            icon: SvgPicture.asset(Assets.assetsStarButton),
            onPressed: () async {
              await context.router.push(const FavoritePage());
              repositoryBloc
                  .add(UpdateRepository(_repositories ?? [], isHistory));
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 24),
            child: SearchWidget(onSearchChanged: _onSearchChanged),
          ),
          Expanded(
              child: BlocConsumer<RepositoryBloc, RepositoryState>(
            listener: (context, state) {
              if (state is RepositoriesInFailure) {
                errorHandler(state.message, context);
              }
            },
            bloc: repositoryBloc,
            builder: (context, state) {
              if (state is SearchRepositoriesInProgress) {
                return const Center(
                  child: SizedBox(
                    width: (50),
                    child: LoadingIndicator(
                      indicatorType: Indicator.lineSpinFadeLoader,
                      colors: [Colors.black12],
                    ),
                  ),
                );
              } else if (state is SearchRepositoriesInSuccess) {
                _repositories = state.list;
                isHistory = state.isHistory;
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _repositories == null || isHistory
                      ? Expanded(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: (16),
                                  left: (16),
                                  right: (16),
                                  bottom: (4)),
                              child: Text(
                                S.of(context).searchHistory,
                                style: descriptionRepository,
                              ),
                            ),
                            Expanded(
                                child: _repositories != null &&
                                        _repositories!.isNotEmpty
                                    ? RepositoriesList(
                                        repositories: _repositories!,
                                        clickFavoriteBtn: (item) {
                                          addOrDeleteFavorite(item);
                                        },
                                        isDismissible: isHistory,
                                        deleteHistory: isHistory
                                            ? (item) {
                                                repositoryBloc.add(
                                                    HistoryListUpdate(
                                                        item: item));
                                              }
                                            : null,
                                      )
                                    : Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(
                                              Assets.assetsNoResult,
                                              width: 40,
                                              height: 40,
                                              alignment: Alignment.center,
                                              fit: BoxFit.contain,
                                            ),
                                            Text(
                                              S.of(context).emptyHistory,
                                              style: emptyText,
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ))
                          ],
                        ))
                      : Expanded(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16,
                                  left: (16),
                                  right: (16),
                                  bottom: (4)),
                              child: Text(
                                S.of(context).whatWeFound,
                                style: descriptionRepository,
                              ),
                            ),
                            Expanded(
                                child: _repositories!.isNotEmpty
                                    ? RepositoriesList(
                                        repositories: _repositories!,
                                        clickFavoriteBtn: (item) {
                                          addOrDeleteFavorite(item);
                                        },
                                        isDismissible: isHistory,
                                        deleteHistory: isHistory
                                            ? (item) {
                                                repositoryBloc.add(
                                                    HistoryListUpdate(
                                                        item: item));
                                              }
                                            : null,
                                      )
                                    : Center(
                                        child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            Assets.assetsNoResult,
                                            width: 40,
                                            height: 40,
                                            alignment: Alignment.center,
                                            fit: BoxFit.contain,
                                          ),
                                          Text(
                                            S.of(context).emptyFound,
                                            style: emptyText,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )))
                          ],
                        ))
                ],
              );
            },
          ))
        ],
      ),
    );
  }

  void addOrDeleteFavorite(RepositoryItem item) {
    repositoryBloc.add(
        AddBookmarkRepository(item, _repositories ?? [], false, isHistory));
  }
}
