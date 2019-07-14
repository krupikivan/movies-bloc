import 'package:flutter/material.dart';
import 'package:flutter_movies/model/trailer.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildTrailerItemView(BuildContext context, Trailer trailer) {
  var width = MediaQuery.of(context).size.width;
  var height = width / 2;
  return InkWell(
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(40.0)),
      child: Card(
        margin: EdgeInsets.only(top: 4, bottom: 4),
        child: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              _buildThumbnailView(trailer.key),
              _buildPlayButtonView(trailer.key),
            ],
          ),
        ),
      ),
    ),
    onTap: () => {},
  );
}

Widget _buildThumbnailView(String videoKey) {
  return Container(
    height: double.maxFinite,
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.transparent,
        image: new DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://img.youtube.com/vi/$videoKey/0.jpg'
            )
        )
    ),
  );
}

Widget _buildPlayButtonView(String videoKey) {
  return Container(
    child: Center(
      child: FloatingActionButton(
        onPressed: () async {
          var url = 'https://www.youtube.com/watch?v=$videoKey';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Error $url';
          }
        },
        backgroundColor: Colors.red,
        child: Icon(
          Icons.play_arrow,
          color: Colors.white,
          size: 40,
        ),
      ),
    ),
  );
}
