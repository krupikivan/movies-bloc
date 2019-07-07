import 'dart:async';

import 'package:flutter_movies/src/bloc/popup_event.dart';
import 'package:flutter_movies/src/model/filter.dart';
import 'package:flutter_movies/src/model/item_model.dart';
import 'package:flutter_movies/src/repo/repository.dart';
import 'package:rxdart/rxdart.dart';

class PopupBloc{

  //Filter _popularFilter = filter[0];
 //Filter _topRatedFilter = filter[1];

  final _repository = Repository();
  final _moviesFetcher = StreamController<ItemModel>();
  Stream<ItemModel> get movies => _moviesFetcher.stream;



  //El stream para escuchar la seleccion del popup si es popular o top rated
  final _popupStateController = StreamController<Filter>();

  //El sink para cargar la seleccion del usuario del popup
  StreamSink<Filter> get _inPopup => _popupStateController.sink;

  //El stream para escuchar el resultado que nos larga
  Stream<Filter> get popupItem => _popupStateController.stream;

  //El stream para manejar el evento si es evento seleccion popular o top rated
  final _popupEventController = StreamController<PopupEvent>();

  //El sink solo para cargar los evento y saber que selecciono el usuarii
  Sink<PopupEvent> get popupEventSink => _popupEventController.sink;

  PopupBloc(){

    //Escuchamos la seleccion del popup si es popular o top rated, escuchamos que selecciono
    //Y lo transformamos en un estado
    _popupEventController.stream.listen(_mapEventToState);
  }

  //Manejamos que va a pasar de acuerdo a cada seleccion del popup
  void _mapEventToState(PopupEvent event) async{
    if(event is PopularEvent) {
      await fetchPopularMovies();
    _inPopup.add(filter[0]);
    }
    else {
      fetchTopRatedMovies();
    _inPopup.add(filter[1]);
    }
  }

  fetchPopularMovies() async {

    ItemModel itemModel = await _repository.fetchPopularMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  fetchTopRatedMovies() async {
    ItemModel itemModel = await _repository.fetchTopRatedMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
    _popupEventController.close();
    _popupStateController.close();
  }
}