import 'package:flutter/material.dart';
import 'package:olx_clone_app/LoginScreen/background.dart';
import 'package:olx_clone_app/LoginScreen/body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: LoginBody(),
    );
  }
}
