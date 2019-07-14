
import 'movie.dart';

class MovieList {
  int page;
  int totalResults;
  int totalPages;
  List<Movie> results = [];

  MovieList(Map<String, dynamic> data) {
    this.page = data['page'];
    this.totalResults = data['total_results'];
    this.totalPages = data['total_pages'];
    for (int i = 0; i < data['results'].length; i++) {
      this.results.add(Movie(data['results'][i]));
    }
  }
}
