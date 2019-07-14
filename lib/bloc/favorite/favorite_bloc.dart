import 'dart:async';
import 'dart:collection';
import 'package:flutter_movies/bloc/bloc_provider.dart';
import 'package:flutter_movies/model/movie.dart';
import 'package:rxdart/rxdart.dart';


class FavoriteBloc implements BlocBase{

  final Set<Movie> _favorites = Set<Movie>();


  BehaviorSubject<Movie> _favoriteAddController = new BehaviorSubject<Movie>();
  Sink<Movie> get inAddFavorite => _favoriteAddController.sink;


  BehaviorSubject<Movie> _favoriteRemoveController = new BehaviorSubject<Movie>();
  Sink<Movie> get inRemoveFavorite => _favoriteRemoveController.sink;

  BehaviorSubject<List<Movie>> _favoritesController = new BehaviorSubject<List<Movie>>(seedValue: []);
  Sink<List<Movie>> get _inFavorites =>_favoritesController.sink;
  Stream<List<Movie>> get outFavorites =>_favoritesController.stream;


  FavoriteBloc(){
    _favoriteAddController.listen(_handleAddFavorite);
    _favoriteRemoveController.listen(_handleRemoveFavorite);
  }

  void dispose(){
    _favoriteAddController.close();
    _favoriteRemoveController.close();
    _favoritesController.close();
  }


  void _handleAddFavorite(Movie movie){
    _favorites.add(movie);

    _notify();
  }

  void _handleRemoveFavorite(Movie movie){
    _favorites.remove(movie);

    _notify();
  }

  void _notify(){
    _inFavorites.add(UnmodifiableListView(_favorites));
  }
}
