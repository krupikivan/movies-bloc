import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_movies/bloc/bloc_provider.dart';
import 'package:flutter_movies/bloc/favorite/favorite_bloc.dart';
import 'package:flutter_movies/bloc/favorite/favorite_movie_bloc.dart';
import 'package:flutter_movies/bloc/movie/movie_detail_bloc.dart';
import 'package:flutter_movies/bloc/movie/movie_detail_bloc_provider.dart';
import 'package:flutter_movies/bloc/trailer/trailer_list_bloc_provider.dart';
import 'package:flutter_movies/model/movie.dart';
import 'package:flutter_movies/screen/movie_detail/reviews.dart';
import 'package:flutter_movies/screen/movie_detail/trailer_list_screen.dart';
import 'package:flutter_movies/widget/sliver_fab.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MovieDetail extends StatefulWidget {
  final Movie movie;
  final BoxFit boxFit;
  final Stream<List<Movie>> favoritesStream;

  MovieDetail({
    Key key,
    this.movie,
    this.boxFit: BoxFit.cover,
    @required this.favoritesStream,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {

  FavoriteMovieBloc _favBloc;
  StreamSubscription _subscription;
  MovieDetailBloc movieBloc;

  @override
  void initState() {
    super.initState();
    _createBloc();
  }

  @override
  void didChangeDependencies() {
    movieBloc = MovieDetailBlocProvider.of(context);
    movieBloc.getMovie(widget.movie.id);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(MovieDetail oldWidget) {
    super.didUpdateWidget(oldWidget);
    _disposeBloc();
    _createBloc();
  }

  void _createBloc() {
    _favBloc = FavoriteMovieBloc(widget.movie);
    _subscription = widget.favoritesStream.listen(_favBloc.inFavorites.add);
  }

  void _disposeBloc() {
    _subscription.cancel();
    _favBloc.dispose();
  }

  @override
  void dispose() {
    movieBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FavoriteBloc blocFavorite = BlocProvider.of<FavoriteBloc>(context);
     return _buildBuilder(context, blocFavorite);
  }

  Widget _buildBuilder(BuildContext context, FavoriteBloc blocFavorite){
    return new Scaffold(
      body: new Builder(
        builder: (context) =>
            _buildContainer(context, blocFavorite),
      ),
    );
  }

  Widget _buildContainer(BuildContext context, FavoriteBloc blocFavorite) {
    return new SliverContainer(
      floatingActionButton: _favButton(context, blocFavorite),
      expandedHeight: 256.0,
      slivers: <Widget>[
        _buildAppBar(context),
        _buildList(context),
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
          title: Text(widget.movie.title,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          background: Image.network(
            "https://image.tmdb.org/t/p/w500${widget.movie.backdropPath}",
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
                                      "https://image.tmdb.org/t/p/w500${widget.movie.posterPath}"
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                SmoothStarRating(
                                  rating: widget.movie.getRating(),
                                  allowHalfRating: true,
                                  size: 20,
                                  starCount: 5,
                                  color: Colors.yellow,
                                  borderColor: Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text('Release date',
                              style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight
                                      .bold),),
                            Text(
                              widget.movie.releaseDate,
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
                    widget.movie.overview, textAlign: TextAlign.center,),
                  Container(margin: EdgeInsets.only(
                      top: 8.0, bottom: 8.0)),
                  Text(
                    "Trailers",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  _buildTrailerScreen(context),
                  Container(margin: EdgeInsets.only(
                      top: 8.0, bottom: 8.0)),
                  Center(
                    child: RaisedButton(
                      child: new Text('Leer comentarios'),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ReviewsPage(
                            id: widget.movie.id,
                          );
                        }));
                      },
                      color: Colors.white,
                        shape: new Border.all(color: Colors.black)
                    ),
                  )
                ],
              ),
            ),
          ]
      ),
    );
  }

 Widget _buildTrailerScreen(BuildContext context) {
   return TrailerListBlocProvider(
     child: TrailerListScreen(
       movieId: widget.movie.id,
     ),
   );
 }


  Widget _favButton(BuildContext context, FavoriteBloc blocFavorite) {
   return StreamBuilder<bool>(
     stream: _favBloc.outIsFavorite,
       initialData: false,
     builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
       return new FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            snapshot.data
                ? Icons.favorite
                : Icons.favorite_border,
            color: snapshot.data ? Colors.red : Colors.grey, size: 35,
          ),
          onPressed: () {
            if (snapshot.data) {
              blocFavorite.inRemoveFavorite.add(widget.movie);
            } else {
              blocFavorite.inAddFavorite.add(widget.movie);
            }
            },
        );
     }
   );
  }
}
