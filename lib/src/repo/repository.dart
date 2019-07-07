import 'dart:async';
import 'package:flutter_movies/src/model/item_model.dart';
import 'package:flutter_movies/src/model/trailer_model.dart';

import 'movie_api_provider.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<ItemModel> fetchMovies(id) => moviesApiProvider.fetchMovieList(id);

  Future<TrailerModel> fetchTrailers(int movieId) => moviesApiProvider.fetchTrailer(movieId);

}
