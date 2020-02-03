import 'package:flutter/material.dart';
import 'homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TODO App",
      theme: ThemeData(primaryColor: Colors.blue),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
