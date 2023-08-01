import 'dart:convert';

class Movie {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String? releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  String? heroId;

  get fullPosterImg {
    if (posterPath != null) {
      return 'https://image.tmdb.org/t/p/w500${this.posterPath}';
    }

    return 'https://scontent.fcue3-1.fna.fbcdn.net/v/t39.30808-6/339597593_215841801061810_5909941518209224999_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeG6iwRIB05w5FcsrPrjhdtJpYcy0oSck-SlhzLShJyT5NBLqvY50cPnBDSy13cF643rPv__q5bQ0FC05UN4SPze&_nc_ohc=o1qZdViG_loAX8UBufq&_nc_ht=scontent.fcue3-1.fna&oh=00_AfDbXAh4YvwIWp_nmll2jtQf9FtZh7CIti0e2fTGKFH3TQ&oe=64C6A07B';
  }

  get fullBackdropPath {
    if (backdropPath != null) {
      return 'https://image.tmdb.org/t/p/w500${this.backdropPath}';
    }

    return 'https://scontent.fcue3-1.fna.fbcdn.net/v/t39.30808-6/339597593_215841801061810_5909941518209224999_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeG6iwRIB05w5FcsrPrjhdtJpYcy0oSck-SlhzLShJyT5NBLqvY50cPnBDSy13cF643rPv__q5bQ0FC05UN4SPze&_nc_ohc=o1qZdViG_loAX8UBufq&_nc_ht=scontent.fcue3-1.fna&oh=00_AfDbXAh4YvwIWp_nmll2jtQf9FtZh7CIti0e2fTGKFH3TQ&oe=64C6A07B';
  }

  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromRawJson(String str) => Movie.fromJson(json.decode(str));

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}
