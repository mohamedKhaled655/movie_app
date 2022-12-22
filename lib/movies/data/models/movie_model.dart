
import '../../domain/entities/movie.dart';

class MovieModel extends Movie{
  const MovieModel({required int id, required String overview, required String title, required String backdropPath, required List<int> genreIds, required dynamic voteAverage, required String releaseDate}) : super(id: id, overview: overview, title: title, backdropPath: backdropPath, genreIds: genreIds, voteAverage: voteAverage, releaseDate: releaseDate);

  factory MovieModel.fromJson(Map<String,dynamic>json)=>MovieModel(
      id: json["id"],
      overview: json["overview"],
      title: json["title"],
      backdropPath: json["backdrop_path"],
      genreIds: List<int>.from(json["genre_ids"].map((e)=>e)),
      voteAverage: json["vote_average"],
      releaseDate: json["release_date"],
  );

}