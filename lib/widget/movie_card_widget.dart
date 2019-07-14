import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_movies/api/api_provider.dart';
import 'package:flutter_movies/bloc/favorite/favorite_movie_bloc.dart';
import 'package:flutter_movies/model/movie.dart';

class MovieCardWidget extends StatefulWidget {
  MovieCardWidget({
    Key key,
    @required this.movie,
    @required this.favoritesStream,
    @required this.onPressed,
  }) : super(key: key);

  final Movie movie;
  final VoidCallback onPressed;
  final Stream<List<Movie>> favoritesStream;

  @override
  MovieCardWidgetState createState() => MovieCardWidgetState();
}

class MovieCardWidgetState extends State<MovieCardWidget> {
  FavoriteMovieBloc _bloc;

  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _createBloc();
  }

  @override
  void didUpdateWidget(MovieCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _disposeBloc();
    _createBloc();
  }

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  void _createBloc() {
    _bloc = FavoriteMovieBloc(widget.movie);
    _subscription = widget.favoritesStream.listen(_bloc.inFavorites.add);
  }

  void _disposeBloc() {
    _subscription.cancel();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[

      new Positioned(
        child: Image.network(
          api.imageBaseUrl + widget.movie.posterPath,
          fit: BoxFit.contain,
        ),
      ),
    ];

    children.add(
      StreamBuilder<bool>(
          stream: _bloc.outIsFavorite,
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return Positioned(
                right: 10.0,
                bottom: 10.0,
                child: Container(
                    padding: const EdgeInsets.all(4.0),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )),
              );
            }else{
              return Positioned(
                right: 10.0,
                bottom: 10.0,
                child: Container(
                    padding: const EdgeInsets.all(4.0),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 30,
                      color: Colors.white,
                    )),
              );
            }
          }),
    );

    return InkWell(
      onTap: widget.onPressed,
      child: Card(
        color: Colors.transparent,
        margin: EdgeInsets.only(
          bottom: 10,
          left: 10,
        ),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: children,
        ),
      ),
    );
  }
}