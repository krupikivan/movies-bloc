import 'package:flutter/material.dart';
import 'package:flutter_movies/bloc/reviews/movie_review_bloc.dart';
import 'package:flutter_movies/bloc/reviews/movie_review_provider.dart';
import 'package:flutter_movies/functions/global_state.dart';
import 'package:flutter_movies/model/movie_reviews.dart';

class ReviewWidget extends StatelessWidget {

  GlobalState _store = GlobalState.instance;

  @override
  Widget build(BuildContext context) {
    final MovieReviewBloc _reviewsMovieBloc = MovieReviewProvider.of(context);
    _reviewsMovieBloc.getMovieReviews(_store.get('idMovie'));
    return Scaffold(
      appBar: AppBar(
        title: Text('Comentarios'),
      ),
      body: Container(
        child: StreamBuilder<MovieReviews>(
            stream: _reviewsMovieBloc.outputReviews,
            builder: (BuildContext context, AsyncSnapshot<MovieReviews> snapshot) {
              return ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.results.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    title: Text(snapshot.data.results[index].author, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textScaleFactor: 1.4),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(snapshot.data.results[index].content, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                    dense: false,
                    contentPadding: EdgeInsets.all(15),
                  );
                }, separatorBuilder: (BuildContext context, int index) {return Divider();},
              );
            }
        ),
      ),
    );
  }
}

