import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../router/router.gr.dart';
import '../../utils/styles.dart';

@RoutePage()
class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: kToolbarHeight),
          Flexible(
            fit: FlexFit.loose,
            flex: 0,
            child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Flexible(
                    fit: FlexFit.loose,
                    flex: 0,
                    child: LottieBuilder.asset(
                        "assets/lottie/no_internet_connection.json",
                        width: MediaQuery.of(context).size.width)),
                const SizedBox(
                  height: 16,
                ),
                IconButton(
                  onPressed: () {
                    context.router.replace(const HomePage());
                  },
                  iconSize: 64,
                  icon: Icon(
                    Icons.refresh,
                    size: 64,
                    color: mainColor,
                  ),
                ),
              ]),
            ),
          ),
          SizedBox(
            height: 16 + MediaQuery.of(context).viewPadding.bottom,
          )
        ],
      ),
    );
  }
}
