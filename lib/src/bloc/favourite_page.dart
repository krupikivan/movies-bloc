import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Favoritos',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.red,
          fontSize: 25.0,
        ),
      ),
    );
  }
}
