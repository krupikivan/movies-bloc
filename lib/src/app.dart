import 'package:flutter/material.dart';
import 'package:flutter_movies/src/ui/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
