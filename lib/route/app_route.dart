import 'package:flutter/material.dart';

import '../screens/mobile/mobile_index.dart';
import '../screens/mobile/screens/login/logins.dart';
import '../screens/mobile/screens/screens.dart';
import '../splash/splash_screen.dart';

class AppRouter {
  static Route router(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return SplashScreen.route();
      case MobileIndex.routeName:
        return MobileIndex.route();
      case WatchlistScreen.routeName:
        return WatchlistScreen.route();
      // case SearchScreen.routeName:
      //   return SearchScreen.route();
      case LogIn.routeName:
        return LogIn.route();
      case ForgotPassword.routeName:
        return ForgotPassword.route();
      case Register.routeName:
        return Register.route();
      case Verification.routeName:
        return Verification.route();
      case EditWatchList.routeName:
        return EditWatchList.route();
      case ChangeMPin.routeName:
        return ChangeMPin.route();
      case ChangePassword.routeName:
        return ChangePassword.route();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("404"),
        ),
        body: const Center(
          child: Expanded(child: Text("Sorry, we couldn't find that page....")),
        ),
      );
    });
  }
}
