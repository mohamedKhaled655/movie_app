
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/base_usecase.dart';
import '../entities/video.dart';
import '../repository/base_movie_repo.dart';



class GetMovieVideoUseCase extends BaseUseCase<List<Videos>,VideoParameters>{
  final BaseMovieRepository baseMovieRepository;

  GetMovieVideoUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Videos>>> call(VideoParameters parameters) async{
    return await baseMovieRepository.getMovieVideo(parameters);
  }

}
class VideoParameters extends Equatable{
  final int movieId;

  const VideoParameters({required this.movieId});

  @override
  // TODO: implement props
  List<Object?> get props => [movieId];
}