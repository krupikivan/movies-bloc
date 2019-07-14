import 'package:flutter_movies/api/repository.dart';
import 'package:flutter_movies/bloc/bloc_provider.dart';
import 'package:flutter_movies/model/movie.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc implements BlocBase{
  final _fetchMovie = PublishSubject<Movie>();
  Observable<Movie> get movieDetailStream => _fetchMovie.stream;
  final repository = Repository();


  void dispose() async {
    await _fetchMovie.drain();
    _fetchMovie.close();
  }
  void getMovie(int movieId) async {
    Movie movie = await repository.getMovie(movieId);
    _fetchMovie.sink.add(movie);
  }
}
