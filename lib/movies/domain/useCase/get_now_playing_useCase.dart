import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/base_usecase.dart';
import '../entities/movie.dart';
import '../repository/base_movie_repo.dart';


class GetNowPlayingMoviesUseCAse extends BaseUseCase<List<Movie>,NoParameters>{
  final BaseMovieRepository baseMovieRepository;

  GetNowPlayingMoviesUseCAse(this.baseMovieRepository);

  //بعمل ال fun بتاع executeوبشوف اذا كنت محتاج ابعت اي paramater في api ولا لا
  @override
  Future<Either<Failure,List<Movie>>> call(NoParameters parameters)async{
    return await baseMovieRepository.getNowPlayingMovies();
  }


}
//دي طريقه حل عادي
// class GetNowPlayingMoviesUseCAse {
//   final BaseMovieRepository baseMovieRepository;
//
//   GetNowPlayingMoviesUseCAse(this.baseMovieRepository);
//
//   //بعمل ال fun بتاع executeوبشوف اذا كنت محتاج ابعت اي paramater في api ولا لا
//   Future<Either<Failure,List<Movie>>> execute()async{
//     return await baseMovieRepository.getNowPlayingMovies();
//   }
// }