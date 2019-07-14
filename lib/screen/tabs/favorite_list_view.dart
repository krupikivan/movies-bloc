import 'package:flutter/material.dart';
import 'package:flutter_movies/bloc/bloc_provider.dart';
import 'package:flutter_movies/bloc/favorite/favorite_bloc.dart';
import 'package:flutter_movies/model/movie.dart';
import 'package:flutter_movies/screen/movie_detail/details.dart';
import 'package:flutter_movies/widget/movie_card_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FavoriteListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FavoriteBloc bloc = BlocProvider.of<FavoriteBloc>(context);
    return StreamBuilder(
        stream: bloc.outFavorites,
        // Display as many FavoriteWidgets
        builder:
            (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            return StaggeredGridView.countBuilder(
              itemCount: snapshot.data.length,
              crossAxisCount: 4,
              scrollDirection: Axis.vertical,
              staggeredTileBuilder: (int index) => new StaggeredTile.count(2, 3),
              itemBuilder: (BuildContext context, int index) {
                //return FavoriteWidget(data: snapshot.data[index],);
                return MovieCardWidget(
                    movie: snapshot.data[index],
                    favoritesStream: bloc.outFavorites,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return DetailsPage(
                          data: snapshot.data[index],
                        );
                      }));
                    });
              },
            );
          }
          return Container();
        },
      );
  }
}
