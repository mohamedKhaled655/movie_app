
import '../../domain/entities/movie_details.dart';

class MovieDetailsModel extends MovieDetial{
  const MovieDetailsModel({required String backdrop_path, required int id, required String overview, required String release_date, required int runtime, required String title, required double vote_average, required List<Genres> genres}) : super(backdrop_path: backdrop_path, id: id, overview: overview, release_date: release_date, runtime: runtime, title: title, vote_average: vote_average, genres: genres);

  factory MovieDetailsModel.fromJson(Map<String,dynamic>json)=>MovieDetailsModel(
      backdrop_path: json["backdrop_path"],
      id: json["id"],
      overview: json["overview"],
      release_date: json["release_date"],
      runtime: json["runtime"],
      title: json["title"],
      vote_average: json["vote_average"],
      genres: List<GenersModel>.from(json["genres"].map((e)=>GenersModel.fromJson(e))),
  );
}

class GenersModel extends Genres{
  const GenersModel({required int id, required String name}) : super(id: id, name: name);

  factory GenersModel.fromJson(Map<String,dynamic>json)=>GenersModel(
      id: json["id"],
  name: json["name"],
  );
}