
import '../../domain/entities/recommendations.dart';

class MovieRecommendationModel extends Recommendations{
  MovieRecommendationModel({required int id, required String? backdrop_path}) : super(id: id, backdrop_path: backdrop_path);

  factory MovieRecommendationModel.fromJson(Map<String,dynamic>json)=>MovieRecommendationModel(
    id: json["id"],
    backdrop_path: json["backdrop_path"]??"/mN0iadY7U4mUvXuoLBwwjtGAD32.jpg",
  );
}