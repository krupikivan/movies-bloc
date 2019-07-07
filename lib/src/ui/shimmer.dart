import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return SafeArea(
      child: StaggeredGridView.countBuilder(
        staggeredTileBuilder: (int index) =>
        new StaggeredTile.count(2, 3),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        crossAxisCount: 4,
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;

          print(time);

          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey[300],
                child: ShimmerLayout(),
                period: Duration(milliseconds: time),
              ));
        },
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 280;
    double containerHeight = 15;

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: new EdgeInsets.all(5.0),
      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: GridTile(
        child: Container(
          color: Colors.grey,
        ),
      ),
    );
  }
}