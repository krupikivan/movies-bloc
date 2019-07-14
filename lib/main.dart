import 'package:flutter/material.dart';
import 'package:flutter_movies/bloc/bloc_provider.dart';
import 'package:flutter_movies/bloc/favorite/favorite_bloc.dart';
import 'package:flutter_movies/bloc/movie/movie_provider.dart';
import 'package:flutter_movies/screen/home_page.dart';
import 'package:flutter_movies/screen/movie_detail/details.dart';
import 'package:flutter_movies/widget/reviews_widget.dart';

import 'bloc/reviews/movie_review_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MovieProvider(
      child: BlocProvider<FavoriteBloc>(
        bloc: FavoriteBloc(),
        child: MovieReviewProvider(
          child: MaterialApp(
            theme: ThemeData(),
            home: new HomePage(),
            initialRoute: '/home',
            routes: <String , WidgetBuilder>{
              '/home': (BuildContext  context) => new HomePage(),
              '/movie_details': (BuildContext  context) => new DetailsPage(),
              '/movie_reviews': (BuildContext  context) => new ReviewWidget(),
            },
          ),
        ),
      ),
    );
  }
}