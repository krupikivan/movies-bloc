import 'package:flutter/material.dart';
import 'package:flutter_movies/src/bloc/movie_detail_provider.dart';
import 'package:flutter_movies/src/model/item_model.dart';

import 'movie_details.dart';

class MovieBuilder extends StatefulWidget {

  final int index;
  final ItemModel itemModel;

  const MovieBuilder({Key key, this.index, this.itemModel}) : super(key: key);

  @override
  _MovieBuilderState createState() => _MovieBuilderState(index, itemModel);
}

class _MovieBuilderState extends State<MovieBuilder>{

  final int index;
  final ItemModel itemModel;

  _MovieBuilderState(this.index, this.itemModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
      index != -1?
          InkWell(
            enableFeedback: true,
            onTap: () => openDetailPage(itemModel, index),
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
      //margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      //decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
    );
  }

  openDetailPage(ItemModel data, int index) {
    final page = MovieDetailProvider(
      child: MovieDetail(
        title: data.results[index].title,
        posterUrl: data.results[index].backdrop_path,
        description: data.results[index].overview,
        releaseDate: data.results[index].release_date,
        voteAverage: data.results[index].vote_average.toString(),
        movieId: data.results[index].id,
      ),
    );
    Navigator.push(context,
      MaterialPageRoute(builder: (context) {
        return page;
      }),
    );
  }
}