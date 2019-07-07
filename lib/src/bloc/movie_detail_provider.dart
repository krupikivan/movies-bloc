import 'package:flutter/material.dart';
import 'package:flutter_movies/src/bloc/movie_detail_bloc.dart';
import 'package:flutter_movies/src/bloc/movie_detail_provider.dart';
export 'package:flutter_movies/src/bloc/movie_detail_provider.dart';

class MovieDetailProvider extends InheritedWidget {
  final MovieDetailBloc bloc;

  MovieDetailProvider({Key key, Widget child})
      : bloc = MovieDetailBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static MovieDetailBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(MovieDetailProvider)
    as MovieDetailProvider)
        .bloc;
  }
}