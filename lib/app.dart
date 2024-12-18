import 'package:flutter/material.dart';
import 'screens/form_screen.dart';
import 'screens/list_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListScreen(),
      routes: {
        '/add-task': (context) => const FormScreen(),
      },
    );
  }
}
