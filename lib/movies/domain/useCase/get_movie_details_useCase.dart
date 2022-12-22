
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


import '../../../core/error/failure.dart';
import '../../../core/usecases/base_usecase.dart';
import '../entities/movie_details.dart';
import '../repository/base_movie_repo.dart';

class GetMovieDetailsUseCase extends BaseUseCase<MovieDetial,MovieDetailsParameters>{
  final BaseMovieRepository baseMovieRepository;

  GetMovieDetailsUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, MovieDetial>> call(MovieDetailsParameters parameters) async{
    return await baseMovieRepository.getMovieDetails(parameters);

  }



}

class MovieDetailsParameters extends Equatable{
  final int movieId;

  const MovieDetailsParameters({required this.movieId});

  @override
  // TODO: implement props
  List<Object?> get props => [movieId];
}