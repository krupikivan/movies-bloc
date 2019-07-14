import 'dart:async';
import 'package:flutter_movies/src/bloc/favorite/favorite_bloc.dart';
import 'package:flutter_movies/src/bloc/favorite/favorite_movie_bloc.dart';
import 'package:flutter_movies/src/bloc/favorite/favorite_provider.dart';
import 'package:flutter_movies/src/bloc/movie/trailer_list_bloc_provider.dart';
import 'package:flutter_movies/src/model/movie.dart';
import 'package:flutter_movies/src/ui/sliver_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/src/bloc/movie/movie_detail_bloc.dart';
import 'package:flutter_movies/src/bloc/movie/movie_detail_provider.dart';
import 'package:flutter_movies/src/model/trailer_model.dart';
import 'package:flutter_movies/src/ui/trailer_list_screen.dart';

class MovieDetail extends StatefulWidget {
  final posterUrl;
  final backdropPath;
  final description;
  final releaseDate;
  final String title;
  final String voteAverage;
  final int movieId;

  MovieDetail({
    this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.movieId,
    this.backdropPath,
  });

  @override
  State<StatefulWidget> createState() {
    return MovieDetailState(
      title: title,
      posterUrl: posterUrl,
      description: description,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      movieId: movieId,
      backdropPath: backdropPath,
    );
  }
}

class MovieDetailState extends State<MovieDetail> {
  final posterUrl;
  final backdropPath;
  final description;
  final releaseDate;
  final String title;
  final String voteAverage;
  final int movieId;

  MovieDetailBloc bloc;
  FavoriteBloc favoriteBloc;
  MovieDetailState({
    this.title,
    this.posterUrl,
    this.backdropPath,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.movieId,
  });
  bool _isFavorite = false;

  @override
  void didChangeDependencies() {
    bloc = MovieDetailProvider.of(context);
    bloc.fetchTrailersById(movieId);
    favoriteBloc = FavoriteProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Builder(
        builder: (context) =>
            _builContainer(context, favoriteBloc),
      ),
    );
  }


  Widget noTrailer(TrailerModel data) {
    return Center(
      child: Container(
        child: Text("No trailer available"),
      ),
    );
  }

  Widget trailerLayout(TrailerModel data) {
    if (data.results.length > 1) {
      return Column(
        children: <Widget>[

          trailerItem(data, 0),

        ],
      );

    } else {
      return Expanded(
        child: Column(
          children: <Widget>[
            trailerItem(data, 0),
          ],
        ),
      );
    }
  }

  Widget trailerItem(TrailerModel data, int index) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5.0),
          height: 100.0,
          color: Colors.grey,
          child: Center(child: Icon(Icons.play_circle_outline, color: Colors.white)),
        ),
        Text(
          data.results[index].name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      elevation: 0.0,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: false,
          title: Text(title,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          background: Image.network(
            "https://image.tmdb.org/t/p/w500$backdropPath",
            fit: BoxFit.cover,
          )),
    );
  }

  Widget _buildList(BuildContext context) {
    return SliverList(
      delegate: new SliverChildListDelegate(
          [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 150.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15.0)
                              ),
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w500$posterUrl"
                                  )
                              )
                          ),
                        ),
                        Container(margin: EdgeInsets.only(
                            left: 25.0)),
                        Column(
                          children: <Widget>[
                            Text('User Rating',
                              style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight
                                      .bold),),
                            Text(
                              voteAverage,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            Text('Release date',
                              style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight
                                      .bold),),
                            Text(
                              releaseDate,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(margin: EdgeInsets.only(
                      top: 8.0, bottom: 8.0)),
                  Text(
                    description, textAlign: TextAlign.center,),
                  Container(margin: EdgeInsets.only(
                      top: 8.0, bottom: 8.0)),
                  Text(
                    "Trailer",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(margin: EdgeInsets.only(
                      top: 8.0, bottom: 8.0)),
                  _buildTrailerScreen(context),
                ],
              ),
            ),
          ]
      ),
    );
  }

  Widget _builContainer(BuildContext context, FavoriteBloc _favoriteBloc) {
    return SliverContainer(
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.white,
        child: StreamBuilder<List<Movie>>(
          stream: _favoriteBloc.outputMovies,
          builder: (BuildContext context,
              AsyncSnapshot<List<Movie>> snapshot) {
            return Positioned(
              top: 16.0,
              right: 16.0,
              child: InkWell(
                onTap: () {
                  for(var i = 0; i < snapshot.data.length; i++){
                    if (snapshot.data[i].id == movieId) {
                      _favoriteBloc.inRemoveFavorite.add(
                        Movie(movieId, voteAverage, title, backdropPath, description, releaseDate),
                      );
                      return;
                    } else {
                      _favoriteBloc.inAddFavorite.add(
                        Movie(movieId, voteAverage, title, backdropPath, description, releaseDate),
                      );
                      setState(() {
                      _isFavorite = true;
                      });
                      return;
                    }
                  }
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      _isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : Colors.white,
                    )),
              ),
            );
          },
        ),

        onPressed: () => {},
      ),
      expandedHeight: 256.0,
      slivers: <Widget>[
        _buildAppBar(context),
        _buildList(context),
      ],
    );
  }

  Widget _buildTrailerScreen(BuildContext context) {
    return TrailerListBlocProvider(
      child: TrailerListScreen(
        movieId: movieId,
      ),
    );
  }
}
