import 'package:flutter/material.dart';
import 'package:github_search_app/router/router.gr.dart';
import 'package:github_search_app/utils/styles.dart';
import 'package:lottie/lottie.dart';
import 'package:auto_route/auto_route.dart';

import '../../generated/l10n.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      context.router.replace(const HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).searchApp,
              style: titleStyle.copyWith(color: textColorWhite),
            ),
            Container(
              width: 130,
              height: 130,
              alignment: Alignment.center,
              child: Lottie.asset("assets/lottie/splash.json",
              repeat: true),
            )
          ],
        ), // Укажите путь к вашему JSON файлу
      ),
    );
  }
}
