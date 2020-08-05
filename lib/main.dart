import 'package:flutter/material.dart';
import 'package:json_api/screens/allPosts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meraaki Learnint',
      debugShowCheckedModeBanner: false,
      home: AllPosts(),
      theme: ThemeData(
        fontFamily: 'Faustina'
      ),
    );
  }
}

