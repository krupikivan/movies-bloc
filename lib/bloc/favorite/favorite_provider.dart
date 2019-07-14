import 'package:flutter/material.dart';
import 'package:flutter_movies/bloc/favorite/favorite_bloc.dart';

class FavoriteProvider extends InheritedWidget {
  final bloc = FavoriteBloc();

  FavoriteProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static FavoriteBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(FavoriteProvider) as FavoriteProvider).bloc;
  }
}