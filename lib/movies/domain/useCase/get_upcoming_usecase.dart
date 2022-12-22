
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/base_usecase.dart';
import '../entities/movie.dart';
import '../repository/base_movie_repo.dart';


class GetUpcomingMovieUseCase extends BaseUseCase<List<Movie>,NoParameters>{
  final BaseMovieRepository baseMovieRepository;

  GetUpcomingMovieUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParameters parameters) async{
    return await baseMovieRepository.getUpcomingMovie();
  }

}