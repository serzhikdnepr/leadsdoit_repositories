import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:github_search_app/router/router.dart';
import 'package:github_search_app/ui/bloc/repository_bloc/repository_bloc.dart';

import 'di/service_locator.dart';
import 'generated/l10n.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    runApp(MyApp());
  }, (Object error, StackTrace stack) async {
    debugPrint("$error");
  });
}

class MyApp extends StatelessWidget {
  final _rootRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<RepositoryBloc>(
            create: (context) => RepositoryBloc(
                serviceLocator.get(),
                serviceLocator.get(),
                serviceLocator.get(),
                serviceLocator.get(),
                serviceLocator.get()),
          ),
        ],
        child: MaterialApp.router(
          theme: ThemeData(
            fontFamily: "Sora",
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: const Locale("en"),
          supportedLocales: S.delegate.supportedLocales,
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: widget!,
            );
          },
          routerConfig: _rootRouter.config(
            navigatorObservers: () => [AutoRouteObserver()],
          ),
        ));
  }
}
