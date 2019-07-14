import 'package:flutter/material.dart';
import 'package:flutter_movies/bloc/bloc_provider.dart';
import 'package:flutter_movies/bloc/favorite/favorite_bloc.dart';
import 'package:flutter_movies/bloc/movie/movie_provider.dart';
import 'package:flutter_movies/screen/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MovieProvider(
      child: BlocProvider<FavoriteBloc>(
        bloc: FavoriteBloc(),
        child: MaterialApp(
          theme: ThemeData(),
          home: HomePage(),
        ),
      ),
    );
  }
}