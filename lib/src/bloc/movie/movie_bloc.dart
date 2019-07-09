import 'package:flutter_movies/src/model/filter.dart';
import 'package:flutter_movies/src/model/item_model.dart';
import 'package:flutter_movies/src/repo/movie_api_provider.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  final repo = MovieApiProvider();

  // final PopupBloc popupBloc;

  //Stream Controller
  final BehaviorSubject<ItemModel> _movieController =
      BehaviorSubject<ItemModel>();
  final BehaviorSubject<Filter> _kindOfMovieController =
      BehaviorSubject<Filter>.seeded(Filter(title: 'Mas populares', id: 0));

  //Streams
  Stream<ItemModel> get outputMovies => _movieController.stream;
  Stream<Filter> get outputFilters => _kindOfMovieController.stream;
  //Sinks
  Sink<ItemModel> get inputMovies => _movieController.sink;
  Sink<Filter> get inputFiltes => _kindOfMovieController.sink;

  //construnctor
  MovieBloc() {
    outputFilters.listen(_handleFilters);
  }



  // Function(ItemModel) get addMovies => _movieController.sink.add;

  getPopularMovies() async {
    ItemModel itemModel = await repo.fetchPopularMovieList();
    inputMovies.add(itemModel);
  }

  // void mapPopupToRepo(int id) async{
  //   if(id == 0) {
  //     ;
  //     _movieController.sink.add(itemModel);
  //   }
  //   else {
  //     ItemModel itemModel = await repo.fetchTopRatedMovieList();
  //     _movieController.sink.add(itemModel);
  //   }
  // }

  dispose() {
    _movieController.close();
    _kindOfMovieController.close();
  }

  Future _handleFilters(Filter filter) async {
    if (filter.id == 0) {
      ItemModel itemModel = await repo.fetchPopularMovieList();
      inputMovies.add(itemModel);
    } else {
      ItemModel itemModel = await repo.fetchTopRatedMovieList();
      print("trajo las top!");
      inputMovies.add(itemModel);
    }
  }
}
