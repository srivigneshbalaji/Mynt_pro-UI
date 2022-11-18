import 'package:flutter/material.dart';

class Verification extends StatelessWidget {
  const Verification({super.key});
  static const String routeName = 'verification';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const Verification(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
