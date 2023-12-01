import 'package:flutter/material.dart';
import 'package:flutter_productos_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
                child: Column(
      children: [SizedBox(height: 250), CardContainer()],
    ))));
  }
}
