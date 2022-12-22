
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


import '../../../core/error/failure.dart';
import '../../../core/usecases/base_usecase.dart';
import '../entities/recommendations.dart';
import '../repository/base_movie_repo.dart';

class GetMovieRecommendationUseCase extends BaseUseCase<List<Recommendations>,MovieRecommendationParameters>{
  final BaseMovieRepository baseMovieRepository;

  GetMovieRecommendationUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Recommendations>>> call(MovieRecommendationParameters parameters) async{
    return await baseMovieRepository.getRecommendationMovie(parameters);
  }

}

class MovieRecommendationParameters extends Equatable{
  final int movieId;

  const MovieRecommendationParameters({required this.movieId});

  @override
  // TODO: implement props
  List<Object?> get props => [movieId];
}