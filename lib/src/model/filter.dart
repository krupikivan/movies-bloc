
import 'package:flutter/material.dart';

class Filter{
  final Text title;
  final int id;
  const Filter({this.title, this.id});
}
const List<Filter> filter = <Filter> [
  const Filter(title: const Text('Mas populares'), id: 0),
  const Filter(title: const Text('Mas valoradas'), id: 1),
];