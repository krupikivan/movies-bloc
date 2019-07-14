
import 'package:flutter/material.dart';
import 'package:flutter_movies/src/bloc/movie/trailer_list_bloc.dart';

class TrailerListBlocProvider extends InheritedWidget {
  final TrailerListBloc bloc;

  TrailerListBlocProvider({Key key, Widget child})
      : bloc = TrailerListBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static TrailerListBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(TrailerListBlocProvider)
            as TrailerListBlocProvider)
        .bloc;
  }
}
