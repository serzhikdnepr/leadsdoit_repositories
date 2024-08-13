import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:github_search_app/ui/home/widgets/view_list_repositories.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../di/service_locator.dart';
import '../../domain/model/repository_item.dart';
import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../utils/app_utils.dart';
import '../../utils/styles.dart';
import '../bloc/repository_bloc/repository_bloc.dart';

@RoutePage()
class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<FavoritePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List<RepositoryItem>? _repositories;
  var repositoryBloc = serviceLocator<RepositoryBloc>();

  @override
  void initState() {
    repositoryBloc.add(FavoriteListRepositories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bgPage,
      appBar: AppBar(
        title: Text(
          S.of(context).listOfFavoriteRepositories,
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
        leading: GFIconButton(
          color: GFColors.TRANSPARENT,
          iconSize: 44,
          padding: const EdgeInsets.only(left: 16),
          icon: SvgPicture.asset(Assets.assetsBackBtn),
          onPressed: () {
            context.router.maybePop();
          },
        ),
        backgroundColor: bgAppBar,
        centerTitle: true,
      ),
      body: BlocConsumer<RepositoryBloc, RepositoryState>(
        bloc: repositoryBloc,
        listener: (context, state) {
          if (state is RepositoriesInFailure) {
            showToast(state.message);
          }
        },
        builder: (context, state) {
          if (state is FavoriteRepositoriesInSuccess) {
            _repositories = state.list;
          } else if (state is SearchRepositoriesInProgress) {
            return const Center(
              child: SizedBox(
                width: (50),
                child: LoadingIndicator(
                  indicatorType: Indicator.lineSpinFadeLoader,
                  colors: [Colors.black12],
                ),
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _repositories == null||!_repositories!.isNotEmpty
                  ? Expanded(
                      child: Center(
                      child: Text(
                        S.of(context).emptyFavoriteList,
                        style: emptyText,
                        textAlign: TextAlign.center,
                      ),
                    ))
                  : Expanded(
                      child: RepositoriesList(
                          repositories: _repositories!,
                          clickFavoriteBtn: (item) {
                            addOrDeleteFavorite(item);
                          },
                        isDismissible: false,
                        ))
            ],
          );
        },
      ),
    );
  }
  void addOrDeleteFavorite(RepositoryItem item) {

    repositoryBloc.add(AddBookmarkRepository(item,_repositories??[], true, false));
  }
}
