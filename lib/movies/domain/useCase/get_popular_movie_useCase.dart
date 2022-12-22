import 'package:dartz/dartz.dart';


import '../../../core/error/failure.dart';
import '../../../core/usecases/base_usecase.dart';
import '../entities/movie.dart';
import '../repository/base_movie_repo.dart';


class GetPopularMoviesUseCase extends BaseUseCase<List<Movie>,NoParameters>{
  final BaseMovieRepository baseMovieRepository;

  GetPopularMoviesUseCase(this.baseMovieRepository);
  Future<Either<Failure,List<Movie>>> call(NoParameters parameters)async{
    return await baseMovieRepository.getPopularMovies();
  }

}

// class GetPopularMoviesUseCase{
//   final BaseMovieRepository baseMovieRepository;
//
//   GetPopularMoviesUseCase(this.baseMovieRepository);
//   Future<Either<Failure,List<Movie>>> execute()async{
//     return await baseMovieRepository.getPopularMovies();
//   }
//
// }