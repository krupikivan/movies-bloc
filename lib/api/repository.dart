import 'dart:async';

import 'package:flutter_movies_bloc/api/api_provider.dart';
import 'package:flutter_movies_bloc/cons/moviedb.dart';
import 'package:flutter_movies_bloc/model/movie.dart';
import 'package:flutter_movies_bloc/model/movie_list.dart';
import 'package:flutter_movies_bloc/model/movie_reviews.dart';
import 'package:flutter_movies_bloc/model/trailer_list.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<MovieList> getPopularMovies() =>
      apiProvider.getMovies(MovieFilter.POPULAR);

  Future<MovieList> getTopRatedMovies() =>
      apiProvider.getMovies(MovieFilter.TOP_RATED);

  Future<Movie> getMovie(int movieId) => apiProvider.getMovie(movieId);

  Future<TrailerList> getMovieTrailers(int movieId) =>
      apiProvider.getMovieTrailers(movieId);

  Future<MovieReviews> getMovieReviews(int movieId) =>
      apiProvider.getMovieReviews(movieId);
}
