
import 'package:flutter_movies/src/model/trailer_list.dart';
import 'package:flutter_movies/src/repo/movie_api_provider.dart';
import 'package:rxdart/rxdart.dart';

class TrailerListBloc {
  final _fetchMovieTrailers = PublishSubject<TrailerList>();
  final repository = MovieApiProvider();
  Observable<TrailerList> get movieTrailersStream => _fetchMovieTrailers.stream;


  void dispose() async {
    await _fetchMovieTrailers.drain();
    _fetchMovieTrailers.close();
  }

  void getMovieTrailers(int movieId) async {
    TrailerList trailerList = await repository.getMovieTrailers(movieId);
    _fetchMovieTrailers.sink.add(trailerList);
  }
}