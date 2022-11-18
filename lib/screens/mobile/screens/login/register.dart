import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});
  static const String routeName = 'register';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const Register(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
