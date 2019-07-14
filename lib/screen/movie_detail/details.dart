import 'package:flutter/material.dart';
import 'package:flutter_movies/bloc/bloc_provider.dart';
import 'package:flutter_movies/bloc/favorite/favorite_bloc.dart';
import 'package:flutter_movies/bloc/movie/movie_detail_provider.dart';
import 'package:flutter_movies/functions/global_state.dart';
import 'package:flutter_movies/screen/movie_detail/movie_details.dart';
class DetailsPage extends StatelessWidget {
  GlobalState _store = GlobalState.instance;

  @override
  Widget build(BuildContext context) {
    return MovieDetailBlocProvider(
      child: MovieDetail(
        movie: _store.get('movie'),
        favoritesStream: BlocProvider.of<FavoriteBloc>(context).outFavorites,
      ),
    );
  }
}
