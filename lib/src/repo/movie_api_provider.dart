import 'dart:async';
import 'dart:convert';
import 'package:flutter_movies/src/model/item_model.dart';
import 'package:flutter_movies/src/model/trailer_model.dart';
import 'package:http/http.dart' show Client;

class MovieApiProvider {
  Client client = Client();
  final _apiKey = '883f4e3915ab44847949954a07a67ac2';
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  Future<ItemModel> fetchPopularMovieList() async {
    final response = await client.get("$_baseUrl/popular?api_key=$_apiKey");
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error en carga');
    }
  }

  Future<ItemModel> fetchTopRatedMovieList() async {
    final response = await client.get("$_baseUrl/top_rated?api_key=$_apiKey");
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error en carga');
    }
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    final response =
    await client.get("$_baseUrl/$movieId/videos?api_key=$_apiKey");

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }

}
