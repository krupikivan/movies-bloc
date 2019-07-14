import 'package:flutter_movies/model/trailer.dart';

class TrailerList {
  int id;
  List<Trailer> results = [];

  TrailerList(Map<String, dynamic> data) {
    this.id = data['id'];
    for (int i = 0; i < data['results'].length; i++) {
      this.results.add(Trailer(data['results'][i]));
    }
  }
}