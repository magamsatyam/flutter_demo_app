class Anime{
  final int id;
  final String image_url;
  final String synopsis;
  final String title;
  final String type;

  Anime({this.id, this.image_url, this.synopsis, this.title, this.type});

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
        id: json['mal_id'],
        image_url: json['image_url'],
        synopsis: json['synopsis'],
        title: json['title'],
        type: json['type']
    );
  }
}