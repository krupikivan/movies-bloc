import 'package:flutter_movies/api/repository.dart';
import 'package:flutter_movies/model/trailer_list.dart';
import 'package:rxdart/rxdart.dart';

class TrailerListBloc {
  final repository = Repository();
  final _fetchMovieTrailers = PublishSubject<TrailerList>();
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