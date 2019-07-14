import 'package:flutter/material.dart';
import 'package:flutter_movies/src/bloc/favorite/favorite_provider.dart';
import 'package:flutter_movies/src/bloc/movie/movie_detail_provider.dart';
import 'package:flutter_movies/src/model/item_model.dart';

import 'movie_details.dart';

class MovieBuilder extends StatelessWidget {

  final int index;
  final ItemModel itemModel;
  const MovieBuilder({Key key, this.index, this.itemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildMovieEachItems(context);
  }

  openDetailPage(ItemModel data, int index, BuildContext context) {
    final page = MovieDetailProvider(
      child: MovieDetail(
        title: data.results[index].title,
        posterUrl: data.results[index].poster_path,
        description: data.results[index].overview,
        releaseDate: data.results[index].release_date,
        voteAverage: data.results[index].vote_average.toString(),
        movieId: data.results[index].id,
        backdropPath: data.results[index].backdrop_path,
      ),
    );
    Navigator.push(context,
      MaterialPageRoute(builder: (context) {
        return page;
      }),
    );
  }

  Widget _buildMovieEachItems(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          index != -1?
          InkWell(
            enableFeedback: true,
            onTap: () => openDetailPage(itemModel, index, context),
            child: Stack(
              children: <Widget>[
                new Positioned(
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w185${itemModel.results[index].poster_path}',
                    fit: BoxFit.contain,
                  ),
                ),
                new Positioned(
                  child: InkWell(
                    onTap: () {
                    },
                    child: Icon(Icons.favorite_border, size: 30, color: Colors.white),
                  ),
                  right: 10.0,
                  bottom: 10.0,
                )
              ],
            ),
          )
              : Expanded(child: Container(color: Colors.grey,)),
        ],
      ),
    );
  }
}