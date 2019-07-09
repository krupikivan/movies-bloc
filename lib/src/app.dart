import 'package:flutter/material.dart';
import 'package:flutter_movies/src/bloc/movie/movie_provider.dart';
import 'package:flutter_movies/src/ui/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MovieProvider(
      child: MaterialApp(
        theme: ThemeData(),
        home: Scaffold(
          body: HomePage(),
        ),
      ),
    );
  }
}
