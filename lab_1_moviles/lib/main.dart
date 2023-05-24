import 'package:flutter/material.dart';
import 'package:lab_1_moviles/screens/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laboratorio #1',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.blueGrey,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
