
class Movie extends Object {
  final int id;
  final vote_average;
  final String title;
  final release_date;
  final String backdrop_path;
  final String description;

  Movie(this.id, this.vote_average, this.title, this.backdrop_path, this.description, this.release_date);

  Movie.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        vote_average = json['vote_average'],
        title = json['title'],
        release_date = json['release_date'],
        backdrop_path = json['poster_path'],
        description = json['overview'];

  @override
  bool operator==(dynamic other) => identical(this, other) || this.id == other.id;

  @override
  int get hashCode => id;
}
