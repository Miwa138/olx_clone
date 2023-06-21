import 'package:flutter/material.dart';
import 'package:olx_clone_app/ForgetPassword/background.dart';
import 'package:olx_clone_app/ForgetPassword/body.dart';

class ForgetPassword extends StatefulWidget {



  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ForgetBody(),
    );
  }
}
