import 'package:flutter/material.dart';
import 'package:flutter_movies/bloc/bloc_provider.dart';
import 'package:flutter_movies/bloc/favorite/favorite_bloc.dart';
import 'package:flutter_movies/model/movie.dart';
import 'package:flutter_movies/model/movie_list.dart';
import 'package:flutter_movies/screen/movie_detail/details.dart';
import 'package:flutter_movies/widget/movie_card_widget.dart';
import 'package:flutter_movies/widget/movie_item_view_shimmer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MovieListView extends StatelessWidget {
  final AsyncSnapshot<MovieList> listItems;
  final FavoriteBloc favoriteBloc;
  const MovieListView({Key key, this.listItems, this.favoriteBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavoriteBloc favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    if (listItems.hasData) {
      return _buildListView(context, listItems.data, favoriteBloc.outFavorites);
    }
    else if (listItems.hasError) {
      return Center(child: Text(listItems.error.toString()));
    }
    return _buildShimmerListView(context);
  }

  Widget _buildListView(BuildContext context, MovieList movies, Stream<List<Movie>> favoritesStream) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: 20,
      scrollDirection: Axis.vertical,
      staggeredTileBuilder: (int index) => new StaggeredTile.count(2, 3),
      itemBuilder: (BuildContext context, int index) {
        return _buildMovieItem(context, movies, index, favoritesStream);
        //return buildMovieItemView(context, movies.results[index]);
      },
    );
  }

  Widget _buildShimmerListView(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: 20,
      scrollDirection: Axis.vertical,
      staggeredTileBuilder: (int index) => new StaggeredTile.count(2, 3),
      itemBuilder: (BuildContext context, int index) {
        return buildMovieShimmerItemView();
      },
    );
  }

  Widget _buildMovieItem(BuildContext context, MovieList movies, int index, Stream<List<Movie>> favoritesStream) {
    final Movie movie =
    (movies.results != null && movies.results.length > index)
        ? movies.results[index]
        : null;

    if (movie == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return MovieCardWidget(
        movie: movie,
        favoritesStream: favoritesStream,
        onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){return DetailsPage(data: movie,);}));

        });
  }
}
