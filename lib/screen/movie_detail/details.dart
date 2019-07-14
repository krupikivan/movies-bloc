import 'package:flutter/material.dart';
import 'package:flutter_movies/bloc/bloc_provider.dart';
import 'package:flutter_movies/bloc/favorite/favorite_bloc.dart';
import 'package:flutter_movies/bloc/movie/movie_detail_bloc_provider.dart';
import 'package:flutter_movies/model/movie.dart';
import 'package:flutter_movies/screen/movie_detail/movie_details.dart';
class DetailsPage extends StatelessWidget {
  DetailsPage({
    Key key,
    this.data,
  }) : super(key: key);

  final Movie data;

  @override
  Widget build(BuildContext context) {
    return MovieDetailBlocProvider(
        child: MovieDetail(
          movie: data,
          favoritesStream: BlocProvider.of<FavoriteBloc>(context).outFavorites,
        ),
      );
  }
}
