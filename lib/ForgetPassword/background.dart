import 'package:flutter/material.dart';

class ForgetBackground extends StatelessWidget {

  final Widget child;

  ForgetBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.teal,],
            begin: Alignment.centerLeft,
            end:Alignment.centerRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )
      ),
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          child,
        ],
      ),


    );
  }
}
