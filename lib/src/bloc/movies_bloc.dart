import 'package:flutter_movies/src/model/item_model.dart';
import 'package:flutter_movies/src/repo/repository.dart';
import 'package:rxdart/rxdart.dart';
class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<ItemModel>();

  Observable<ItemModel> get movies => _moviesFetcher.stream;

  fetchMovies() async {
    ItemModel itemModel = await _repository.fetchPopularMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() async{
    await _moviesFetcher.drain();
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc();
