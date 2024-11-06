import 'package:flutter/material.dart';
import 'package:computadoras/db/database_helper.dart';

import 'screens/welcome_screen.dart';
import 'screens/computadoras_screen.dart';
import 'screens/edit_computadora_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Computadoras',
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/computadoras': (context) => ComputadorasScreen(),
        '/edit_computadora': (context) => EditComputadoraScreen(),
      },
    );
  }
}
