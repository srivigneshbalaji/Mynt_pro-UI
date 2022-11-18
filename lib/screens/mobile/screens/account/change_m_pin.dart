import 'package:flutter/material.dart';

class ChangeMPin extends StatelessWidget {
  const ChangeMPin({super.key});
  static const String routeName = 'changeMPin';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ChangeMPin(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Text("Change M-PIN"),
      ),
    );
  }
}
