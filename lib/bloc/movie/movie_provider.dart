import 'package:flutter/material.dart';
import 'package:flutter_movies/bloc/movie/movie_bloc.dart';

class MovieProvider extends InheritedWidget {
  final bloc = MovieBloc();

  MovieProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static MovieBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(MovieProvider) as MovieProvider).bloc;
  }
}