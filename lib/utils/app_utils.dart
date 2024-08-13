import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../router/router.gr.dart';

class AppUtils {
  static bool isFastDoubleClick() {
    var lastClickTime = 0;
    var time0 = 800;
    var time = DateTime.now().millisecondsSinceEpoch;
    if (time - lastClickTime < time0) {
      return true;
    }
    lastClickTime = time;
    return false;
  }
}

void launchURL(String? url) async {
  if (url != null) {
    await launchUrlString(mode: LaunchMode.externalApplication,
      url,
    );
  }
}

void showToast(String? message) {
  Fluttertoast.showToast(
    msg: message != null && message.isNotEmpty ? message : "error",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 5,
  );
}

errorHandler(String message, BuildContext context) {
   if (message == "NetworkException") {
    context.router.replaceAll([const NoInternetPage()]);
  } else {
     showToast(message);
  }
}