class Filter{
  final String title;
  final int id;
  const Filter({this.title, this.id});
}

const List<Filter> filter = <Filter> [
  const Filter(title: 'Mas populares', id: 0),
  const Filter(title: 'Mas valoradas', id: 1),
];