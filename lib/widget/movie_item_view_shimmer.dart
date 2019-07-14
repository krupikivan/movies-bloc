import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildMovieShimmerItemView() {
  return SizedBox(
    child: Shimmer.fromColors(
      baseColor: Colors.grey[200],
      highlightColor: Colors.grey[500],
      child: Card(
        margin: EdgeInsets.only(
          bottom: 30,
          left: 10,
        ),
        elevation: 0.0,
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SizedBox(width: 125),
      ),
    ),
  );
}
