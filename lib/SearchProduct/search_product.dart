import 'package:flutter/material.dart';

class SearchProduct extends StatefulWidget {


  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text('Поиск'),
       automaticallyImplyLeading: false,
       backgroundColor: Colors.blue,
     ),
    );
  }
}
