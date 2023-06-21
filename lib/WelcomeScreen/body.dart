import 'package:flutter/material.dart';
import 'package:olx_clone_app/LoginScreen/login_screen.dart';
import 'package:olx_clone_app/SignUpScreen/signup_screen.dart';
import 'package:olx_clone_app/WelcomeScreen/background.dart';
import 'package:olx_clone_app/Widgets/rounded_button.dart';
import 'background.dart';

class WelcomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WelcomeBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'OLX Clone',
              style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            RoundedButton(text: "Войти", color: Colors.black54, textColor: Colors.white, press: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
            }),
            SizedBox(height: 20,),
            RoundedButton(text: "Регистрация", color: Colors.black54, textColor: Colors.white, press: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
            }),
          ],
        ),
      ),
    );
  }
}
