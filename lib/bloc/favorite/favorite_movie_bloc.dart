import 'dart:async';
import 'package:flutter_movies/model/movie.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteMovieBloc {
  final BehaviorSubject<bool> _isFavoriteController = BehaviorSubject<bool>();
  Stream<bool> get outIsFavorite => _isFavoriteController.stream;

  final StreamController<List<Movie>> _favoritesController = StreamController<List<Movie>>();
  Sink<List<Movie>> get inFavorites => _favoritesController.sink;


  FavoriteMovieBloc(Movie movie){

    _favoritesController.stream
        .map((list) => list.any((Movie item) => item.id == movie.id))
        .listen((isFavorite) => _isFavoriteController.add(isFavorite));
  }
  void dispose(){
    _favoritesController.close();
    _isFavoriteController.close();
  }
}