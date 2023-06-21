import 'package:flutter/material.dart';
import 'package:olx_clone_app/SignUpScreen/body.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SignUpBody(),
    );
  }
}
