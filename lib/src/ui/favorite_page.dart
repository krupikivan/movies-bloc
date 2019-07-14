import 'package:flutter/material.dart';
import 'package:flutter_movies/src/bloc/favorite/favorite_provider.dart';
import 'package:flutter_movies/src/model/movie.dart';
import 'package:flutter_movies/src/ui/favorite_builder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _favoriteBloc = FavoriteProvider.of(context);
    return StreamBuilder<List<Movie>>(
      stream: _favoriteBloc.outputMovies,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
         _buildShimmerEffect(context);
        }
        _buildList(context, snapshot.data);
      },
    );
  }

  Widget _buildShimmerEffect(BuildContext context) {
    return Container(
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: 20,
        itemBuilder: (context, index) => Shimmer.fromColors(
            baseColor: Colors.grey[400],
            highlightColor: Colors.white,
            child: FavoriteBuilder(index: -1)),
        staggeredTileBuilder: (int index) =>
        new StaggeredTile.count(2, 3),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Movie> data) {
    return Container(
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: 20,
        itemBuilder: (context, index) =>
            FavoriteBuilder(
                index: index,
                movie: data
            ),
        staggeredTileBuilder: (int index) => new StaggeredTile.count(2, 3),
      ),
    );
  }


}
