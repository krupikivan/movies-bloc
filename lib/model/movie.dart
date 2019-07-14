

class Movie {
  bool adult;
  int id;
  String originalTitle;
  String overview;
  num voteAverage;
  int runtime;
  String releaseDate;
  String tagline;
  String title;
  String posterPath;
  String backdropPath;

  Movie(Map<String, dynamic> data) {
    this.adult = data['adult'];
    this.id = data['id'];
    this.originalTitle = data['original_title'];
    this.overview = data['overview'];
    this.voteAverage = data['vote_average'];
    this.runtime = data['runtime'];
    this.releaseDate = data['release_date'];
    this.tagline = data['tagline'];
    this.title = data['title'];
    this.posterPath = data['poster_path'];
    this.backdropPath = data['backdrop_path'];
  }

  Movie.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        voteAverage = json['vote_average'],
        title = json['title'],
        posterPath = json['poster_path'],
        overview = json['overview'];

  String getYear() {
    if (releaseDate != null) {
      return DateTime.parse(this.releaseDate).year.toString();
    } else {
      return '';
    }
  }

  String getRuntime() {
    if (runtime != null) {
      return '${this.runtime} mins';
    } else {
      return '';
    }
  }

  double getRating() {
    if(voteAverage != null) {
      return this.voteAverage / 2;
    } else {
      return 0.0;
    }
  }

  int getId() {
    return id;
  }
}
