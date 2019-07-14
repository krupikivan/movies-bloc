import 'dart:async';

import 'package:flutter_movies/model/filter.dart';

enum NavbarItem { INICIO, FAVORITOS}


class NavbarBloc{
  final StreamController<NavbarItem> _navBarController =
      StreamController<NavbarItem>.broadcast();

  final StreamController<String> _titleController =
      StreamController<String>.broadcast();

  NavbarItem defaultItem = NavbarItem.INICIO;

  Stream<NavbarItem> get itemStream => _navBarController.stream;

  Stream<String> get titleOut => _titleController.stream;
  Sink<String> get titleIn => _titleController.sink;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavbarItem.INICIO);
        _titleController.sink.add( filter[0].title);
        break;
      case 1:
        _navBarController.sink.add(NavbarItem.FAVORITOS);
        _titleController.sink.add("Favoritos");
        break;
    }
  }

  close() {
    _navBarController?.close();
    _titleController?.close();
  }
}