
import 'package:flutter/material.dart';
import 'screens/computer_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Computer Database',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ComputerListScreen(),
    );
  }
}
