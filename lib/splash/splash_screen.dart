import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Local_Auth/auth.dart';
import '../model/models.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
  static const String routeName = 'splash';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SplashScreen(),
    );
  }
}

class _SplashScreenState extends State<SplashScreen> {
  void appLock(BuildContext context) async {
    bool authStatus = await BiometricAuthService.authenticateBioMetrics();

    if (authStatus) {
      if (mounted) {
        Navigator.pushNamed(context, 'mobIndex');
      }
    } else {
      Navigator.pushNamed(context, 'mobIndex');
    }

    //  else {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         backgroundColor: Colors.white70,
    //         title: Text(" Authorization Status"),
    //         content: Text(
    //           "Auth Failed",
    //           style: TextStyle(color: Colors.red),
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () {
    //               showDialog<void>(
    //                 context: context,
    //                 builder: (context) {
    //                   return ScreenLock(
    //                     title: Text("Please enter your Login PIN"),
    //                     maxRetries: 3,
    //                     correctString: "1234",
    //                     onCancelled: Navigator.of(context).pop,
    //                     onUnlocked: (() => Navigator.pushReplacement(
    //                         context,
    //                         MaterialPageRoute(
    //                             builder: (context) => SplashScreen()))),
    //                   );
    //                 },
    //               );
    //             },
    //             child: Container(
    //               color: Colors.green,
    //               padding: const EdgeInsets.all(14),
    //               child: const Text("Open with PIN"),
    //             ),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }
  }

  @override
  void initState() {
    initialRoute();
    super.initState();
  }

  String session = "";
  String userId = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SvgPicture.asset("assets/zblogo.svg")),
    );
  }

  Future initialRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      session = prefs.getString('userSession')!;
      ConstVariable.userId = prefs.getString('userId')!;
      ConstVariable.sessionId = prefs.getString('userSession')!;
      log("SessionID ::$session");
      ConstVariable.authStatus = prefs.getBool('bioAuth')!;
      Timer(const Duration(microseconds: 350), () {
        if (session.isEmpty) {
          Navigator.pushNamed(context, 'logIn');
        } else {
          if (ConstVariable.authStatus) {
            appLock(context);
          } else {
            Navigator.pushNamed(context, 'mobIndex');
          }
        }
      });
    } catch (e) {
      Timer(const Duration(microseconds: 350), () {
        if (session.isEmpty) {
          Navigator.pushNamed(context, 'logIn');
        } else {
          if (ConstVariable.authStatus) {
            appLock(context);
          } else {
            Navigator.pushNamed(context, 'mobIndex');
          }
        }
      });
    }
  }
}
