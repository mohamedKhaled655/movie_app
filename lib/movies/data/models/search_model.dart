
import '../../domain/entities/search.dart';

class SearchModel extends Search{
  SearchModel({required int id, required String overview, required String title, required String backdropPath}) : super(id: id, overview: overview, title: title, backdropPath: backdropPath);

  factory SearchModel.fromJson(Map<String,dynamic>json)=>SearchModel(
    id: json["id"]??"",
    overview: json["overview"]??"",
    title: json["title"]??"",
    backdropPath: json["backdrop_path"]??"",
  );
}