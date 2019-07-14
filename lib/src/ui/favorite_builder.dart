
import 'package:flutter/material.dart';
import 'package:flutter_movies/src/bloc/movie/movie_detail_provider.dart';
import 'package:flutter_movies/src/model/movie.dart';
import 'movie_details.dart';

class FavoriteBuilder extends StatelessWidget {

  final int index;
  final List<Movie> movie;

  const FavoriteBuilder({Key key, this.index, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          index != -1 ?
          InkWell(
            enableFeedback: true,
            onTap: () => openDetailPage(movie, index, context),
            child: Stack(
              children: <Widget>[
                new Positioned(
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w185${movie[index].backdrop_path}',
                    fit: BoxFit.contain,
                  ),
                ),
                new Positioned(
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                        Icons.favorite_border, size: 30, color: Colors.white),
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

  openDetailPage(List<Movie> data, int index, BuildContext context) {
    final page = MovieDetailProvider(
      child: MovieDetail(
        title: data[index].title,
        posterUrl: data[index].backdrop_path,
        description: data[index].description,
        releaseDate: data[index].release_date,
        voteAverage: data[index].vote_average.toString(),
        movieId: data[index].id,
      ),
    );
    Navigator.push(context,
      MaterialPageRoute(builder: (context) {
        return page;
      }),
    );
  }
}