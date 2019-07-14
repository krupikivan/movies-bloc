import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_movies/model/movie.dart';
import 'package:flutter_movies/model/movie_reviews.dart';
import 'package:flutter_movies/model/trailer_list.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter_movies/model/movie_list.dart';

class ApiProvider {

  static const String api_key = "883f4e3915ab44847949954a07a67ac2";
  static const String baseUrl = "http://api.themoviedb.org/3/movie";
  final String imageBaseUrl = 'http://image.tmdb.org/t/p/w185/';
  Client _client = Client();

  Future<MovieList> getMovies(String type) async {
    final response = await _client.get('$baseUrl/$type?api_key=$api_key');
    if (response.statusCode == HttpStatus.ok) {
      print(response.request.url.toString());
      return MovieList(json.decode(response.body));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<Movie> getMovie(int movieId) async {
    final response = await _client.get('$baseUrl/$movieId?api_key=$api_key');
    if (response.statusCode == HttpStatus.ok) {
      print(response.request.url.toString());
      return Movie(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie');
    }
  }

  Future<MovieReviews> getMovieReviews(int movieId) async {
    final response = await _client.get('$baseUrl/$movieId/reviews?api_key=$api_key');
    if (response.statusCode == HttpStatus.ok) {
      print(response.request.url.toString());
      return MovieReviews(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie');
    }
  }

  Future<TrailerList> getMovieTrailers(int movieId) async {
    final response = await _client.get('$baseUrl/$movieId/videos?api_key=$api_key');
    if(response.statusCode == HttpStatus.ok) {
      print(response.request.url.toString());
      return TrailerList(json.decode(response.body));
    } else {
      throw Exception('Failed to love movie trailers');
    }
  }

}

ApiProvider api = ApiProvider();
