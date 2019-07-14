import 'package:flutter_movies/model/reviews.dart';

class MovieReviews {
  int id;
  int page;
  List<Reviews> results = [];

  MovieReviews(Map<String, dynamic> data) {
    this.id = data['id'];
    this.page = data['page'];
    for (int i = 0; i < data['results'].length; i++) {
      this.results.add(Reviews(data['results'][i]));
    }
  }
}
