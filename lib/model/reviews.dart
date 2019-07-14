class Reviews {
  String author;
  String content;
  String id;
  String url;

  Reviews(Map<String, dynamic> data) {
    this.author = data['author'];
    this.content = data['content'];
    this.id = data['id'];
    this.url = data['url'];
  }

  Reviews.fromJSON(Map<String, dynamic> json)
      : author = json['author'],
        content = json['content'];
}
