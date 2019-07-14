import 'package:flutter_movies/api/repository.dart';
import 'package:flutter_movies/model/movie_list.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_movies/model/filter.dart';

class MovieBloc {
  final repository = Repository();

  ///-------------------------------Popup Filter
  final BehaviorSubject<Filter> _kindOfMovieController =
  BehaviorSubject<Filter>(seedValue: Filter(title: 'Mas populares', id: 0));
  Stream<Filter> get outputFilters => _kindOfMovieController.stream;
  Sink<Filter> get inputFiltes => _kindOfMovieController.sink;
  ///-------------------------------Popup Filter

  ///-------------------------------Movie Type
  final BehaviorSubject<MovieList> _movieController = BehaviorSubject<MovieList>();
  Stream<MovieList> get outputMovies => _movieController.stream;
  Sink<MovieList> get inputMovies => _movieController.sink;
  ///-------------------------------Movie Type


  MovieBloc() {
    outputFilters.listen(_handleFilters);
  }

  Future _handleFilters(Filter filter) async {
    if (filter.id == 0) {
      getPopularMovies();
    } else {
      getTopRatedMovies();
    }
  }

  void getPopularMovies() async {
    MovieList movieList = await repository.getPopularMovies();
    inputMovies.add(movieList);
  }

  void getTopRatedMovies() async {
    MovieList movieList = await repository.getTopRatedMovies();
    inputMovies.add(movieList);
  }

  void dispose() {
    _kindOfMovieController.close();
    _movieController.close();
  }
}
