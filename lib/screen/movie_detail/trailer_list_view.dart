import 'package:flutter/material.dart';
import 'package:flutter_movies/model/trailer_list.dart';
import 'package:flutter_movies/widget/trailer_item_view.dart';

class TrailerListView extends StatelessWidget {
  final AsyncSnapshot<TrailerList> listItems;

  const TrailerListView({Key key, this.listItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Populate list view with the data
    if (listItems.hasData) {
      return _buildListView(context, listItems.data);
    }
    // Display loading indicator
    else if (listItems.hasError) {
      return Center(child: Text(listItems.error.toString()));
    }
    // Display shimmer loading view
    return _buildShimmerView(context);
  }

  Widget _buildListView(BuildContext context, TrailerList trailers) {
    return Container(
      height: MediaQuery.of(context).size.height/2,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: trailers.results.length,
        itemBuilder: (BuildContext context, int index) {
          return buildTrailerItemView(context, trailers.results[index]);
        },
      ),
    );
  }

  Widget _buildShimmerView(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
