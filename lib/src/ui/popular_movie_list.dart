import 'package:flutter/material.dart';
import 'package:flutter_movies/src/bloc/movies_bloc.dart';
import 'package:flutter_movies/src/model/item_model.dart';
import 'package:flutter_movies/src/ui/movie_builder_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class PopularPage extends StatefulWidget {
  final int id;

  const PopularPage({Key key, this.id}) : super(key: key);
  @override
  _PopularPageState createState() => _PopularPageState(id);
}

class _PopularPageState extends State<PopularPage>{
  final int id;

  _PopularPageState(this.id);

  @override
  void initState() {
    bloc.fetchMovies(id);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.movies,
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          //CON SHIMMER
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
        //SIN SHIMMER
        return StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: 20,
          itemBuilder: (context, index) => MovieBuilder(index: index, itemModel: snapshot.data),
          staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, 3),
        );
      },
    );
  }
}
