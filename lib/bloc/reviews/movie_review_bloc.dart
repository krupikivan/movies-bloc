import 'package:flutter_movies/api/repository.dart';
import 'package:flutter_movies/model/movie_reviews.dart';
import 'package:rxdart/rxdart.dart';

class MovieReviewBloc {
  final repository = Repository();

  final BehaviorSubject<MovieReviews> _reviewsController = BehaviorSubject<MovieReviews>();
  Stream<MovieReviews> get outputReviews => _reviewsController.stream;
  Sink<MovieReviews> get inputReviews => _reviewsController.sink;


  void getMovieReviews(int movieId) async {
    MovieReviews movieReviews = await repository.getMovieReviews(movieId);
    inputReviews.add(movieReviews);
  }


  void dispose() {
    _reviewsController.close();
  }
}
