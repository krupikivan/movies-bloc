import 'package:flutter/material.dart';
import 'package:flutter_movies/bloc/trailer/trailer_list_bloc.dart';
import 'package:flutter_movies/bloc/trailer/trailer_list_bloc_provider.dart';
import 'package:flutter_movies/model/trailer_list.dart';
import 'package:flutter_movies/screen/movie_detail/trailer_list_view.dart';

class TrailerListScreen extends StatefulWidget {
  final int movieId;

  const TrailerListScreen({Key key, this.movieId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TrailerListScreenState();
  }
}

class TrailerListScreenState extends State<TrailerListScreen> {
  TrailerListBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = TrailerListBlocProvider.of(context);
    bloc.getMovieTrailers(widget.movieId);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.movieTrailersStream,
      builder: (BuildContext context, AsyncSnapshot<TrailerList> snapshot) {
        return TrailerListView(listItems: snapshot);
      },
    );
  }
}
