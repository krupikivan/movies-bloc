import 'package:flutter/material.dart';
import 'package:flutter_movies/src/bloc/movie/movie_provider.dart';
import 'package:flutter_movies/src/model/item_model.dart';
import 'package:flutter_movies/src/ui/movie_builder_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class MoviePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final _movieBloc = MovieProvider.of(context);
    return StreamBuilder<ItemModel>(
      stream: _movieBloc.outputMovies,
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
             return _buildShimmerEffect(context);

        }
            return _buildMovies(context, snapshot.data);
      },
    );
  }

  Widget _buildShimmerEffect(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: 20,
      itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey[400],
          highlightColor: Colors.white,
          child: MovieBuilder(index: -1)),
      staggeredTileBuilder: (int index) =>
      new StaggeredTile.count(2, 3),
    );
  }

  Widget _buildMovies(BuildContext context, data) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: 20,
      itemBuilder: (context, index) =>
          MovieBuilder(
              index: index,
              itemModel: data
          ),
      staggeredTileBuilder: (int index) => new StaggeredTile.count(2, 3),
    );
  }
}
