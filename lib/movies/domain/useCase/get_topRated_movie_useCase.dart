import 'package:dartz/dartz.dart';


import '../../../core/error/failure.dart';
import '../../../core/usecases/base_usecase.dart';
import '../entities/movie.dart';
import '../repository/base_movie_repo.dart';

class GetTopRatedMoviesUseCase extends BaseUseCase<List<Movie>,NoParameters>{
  final BaseMovieRepository baseMovieRepository;

  GetTopRatedMoviesUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParameters parameters)async {
    return await baseMovieRepository.getTopRatedMovies();
  }

  // Future<Either<Failure,List<Movie>>>execute()async{
  //   return await baseMovieRepository.getTopRatedMovies();
  // }
}