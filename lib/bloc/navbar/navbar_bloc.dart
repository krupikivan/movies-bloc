import 'dart:async';

import 'package:flutter_movies/bloc/movie/movie_bloc.dart';
import 'package:flutter_movies/model/filter.dart';

enum NavbarItem { INICIO, FAVORITOS}


class NavbarBloc{
  final StreamController<NavbarItem> _navBarController =
      StreamController<NavbarItem>.broadcast();

  
  NavbarItem defaultItem = NavbarItem.INICIO;

  Stream<NavbarItem> get itemStream => _navBarController.stream;



  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavbarItem.INICIO);
        break;
      case 1:
        _navBarController.sink.add(NavbarItem.FAVORITOS);
        break;
    }
  }


  
  close() {
    _navBarController?.close();
  }
}