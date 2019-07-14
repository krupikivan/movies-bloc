import 'package:flutter/material.dart';
import 'package:flutter_movies/bloc/reviews/movie_review_provider.dart';
import 'package:flutter_movies/widget/reviews_widget.dart';

class ReviewsPage extends StatelessWidget {
  ReviewsPage({
    this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return MovieReviewProvider(
        child: ReviewWidget(
          id: id,
        ),
      );
  }
}
