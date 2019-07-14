import 'package:flutter/material.dart';
import 'package:flutter_movies/bloc/reviews/movie_review_bloc.dart';

class MovieReviewProvider extends InheritedWidget {
  final bloc = MovieReviewBloc();

  MovieReviewProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static MovieReviewBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(MovieReviewProvider) as MovieReviewProvider).bloc;
  }
}