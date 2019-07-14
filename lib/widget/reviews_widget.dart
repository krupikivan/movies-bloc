import 'package:flutter/material.dart';
import 'package:flutter_movies/bloc/bloc_provider.dart';
import 'package:flutter_movies/bloc/reviews/movie_review_bloc.dart';
import 'package:flutter_movies/bloc/reviews/movie_review_provider.dart';
import 'package:flutter_movies/model/movie_reviews.dart';

class ReviewWidget extends StatelessWidget {

  final int id;

  const ReviewWidget({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieReviewBloc _reviewsMovieBloc = MovieReviewProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Comentarios'),
      ),
      body: Container(
        child: StreamBuilder<MovieReviews>(
            stream: _reviewsMovieBloc.outputReviews,
            builder: (BuildContext context, AsyncSnapshot<MovieReviews> snapshot) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.results.length,
                  itemBuilder: (BuildContext context, int index){
                   return ListTile(
                     title: Text(snapshot.data.results[index].author),
                     subtitle: Text(snapshot.data.results[index].content),
                   );
                  }
              );
            }
          ),
      ),
    );
  }

  Widget _buildReviews(BuildContext context) {

  }
}

