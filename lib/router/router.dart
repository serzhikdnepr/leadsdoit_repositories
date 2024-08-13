import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:github_search_app/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.custom(
        reverseDurationInMilliseconds: 200,
        transitionsBuilder: (ctx, animation1, animation2, child) {
          debugPrint('Anim2 ${animation2.value}');
          return child;
        },
      );

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: HomePage.page),
        AutoRoute(
          path: '/favoritePage',
          page: FavoritePage.page,
        ),
        AutoRoute(
          page: NoInternetPage.page,
        ),
        RedirectRoute(path: '*', redirectTo: '/'),
      ];
}
