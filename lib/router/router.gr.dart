// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:github_search_app/ui/home/favorite_page.dart' as _i1;
import 'package:github_search_app/ui/home/main_page.dart' as _i2;
import 'package:github_search_app/ui/home/no_internet_page.dart' as _i3;
import 'package:github_search_app/ui/splash/splash_screen.dart' as _i4;

/// generated route for
/// [_i1.FavoritePage]
class FavoritePage extends _i5.PageRouteInfo<void> {
  const FavoritePage({List<_i5.PageRouteInfo>? children})
      : super(
          FavoritePage.name,
          initialChildren: children,
        );

  static const String name = 'FavoritePage';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.FavoritePage();
    },
  );
}

/// generated route for
/// [_i2.HomePage]
class HomePage extends _i5.PageRouteInfo<void> {
  const HomePage({List<_i5.PageRouteInfo>? children})
      : super(
          HomePage.name,
          initialChildren: children,
        );

  static const String name = 'HomePage';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.NoInternetPage]
class NoInternetPage extends _i5.PageRouteInfo<void> {
  const NoInternetPage({List<_i5.PageRouteInfo>? children})
      : super(
          NoInternetPage.name,
          initialChildren: children,
        );

  static const String name = 'NoInternetPage';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.NoInternetPage();
    },
  );
}

/// generated route for
/// [_i4.SplashScreen]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SplashScreen();
    },
  );
}
