import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'route/app_route.dart';
import 'splash/splash_screen.dart';
import 'themes/theme.dart';
import 'themes/theme_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer(builder: (context, ThemeModel themeNotifier, child) {
        return MaterialApp(
          title: 'MYNT',
          theme:
              // ThemeData(fontFamily: 'Rajdhani'),
              themeNotifier.isDark ? MyThemes.darkTheme : MyThemes.lightTheme,
          onGenerateRoute: AppRouter.router,
          initialRoute: SplashScreen.routeName,
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
