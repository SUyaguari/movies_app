import 'dart:convert';

class CreditResponse {
  int id;
  List<Cast> cast;
  List<Cast> crew;

  CreditResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory CreditResponse.fromRawJson(String str) =>
      CreditResponse.fromJson(json.decode(str));

  factory CreditResponse.fromJson(Map<String, dynamic> json) =>
      CreditResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
      );

}

class Cast {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int? castId;
  String? character;
  String creditId;
  int? order;
  String? department;
  String? job;

  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  get fullProfilePath {
    if (profilePath != null){
      return 'https://image.tmdb.org/t/p/w500${this.profilePath}';
    }

    return 'https://scontent.fcue3-1.fna.fbcdn.net/v/t39.30808-6/339597593_215841801061810_5909941518209224999_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeG6iwRIB05w5FcsrPrjhdtJpYcy0oSck-SlhzLShJyT5NBLqvY50cPnBDSy13cF643rPv__q5bQ0FC05UN4SPze&_nc_ohc=o1qZdViG_loAX8UBufq&_nc_ht=scontent.fcue3-1.fna&oh=00_AfDbXAh4YvwIWp_nmll2jtQf9FtZh7CIti0e2fTGKFH3TQ&oe=64C6A07B';
  }

  factory Cast.fromRawJson(String str) => Cast.fromJson(json.decode(str));

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["department"],
        job: json["job"],
      );
}
