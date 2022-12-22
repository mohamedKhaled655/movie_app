import 'package:dartz/dartz.dart';


import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../domain/entities/keywords.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/recommendations.dart';
import '../../domain/entities/search.dart';
import '../../domain/entities/video.dart';
import '../../domain/repository/base_movie_repo.dart';
import '../../domain/useCase/get_movie_details_useCase.dart';
import '../../domain/useCase/get_movie_recommendation_useCase.dart';
import '../../domain/useCase/get_movie_video_usecase.dart';
import '../../domain/useCase/get_search_usecase.dart';
import '../dataSource/movie_remote_data_source.dart';

class MoviesRepository extends BaseMovieRepository{
  final BaseMovieRemoteDataSource baseMovieRemoteDataSource;


  MoviesRepository(this.baseMovieRemoteDataSource);

  @override
  Future<Either<Failure,List<Movie>>> getNowPlayingMovies() async{
    final result=await baseMovieRemoteDataSource.getNowPlayingMovies();
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure,List<Movie>>> getPopularMovies() async{
   final result=await baseMovieRemoteDataSource.getPopularMovies();
   try{
     return Right(result);
   }on ServerException catch(failure){
     return Left(ServerFailure(failure.errorMessageModel.statusMessage));
   }
  }

  @override
  Future<Either<Failure,List<Movie>>> getTopRatedMovies()async {
    final result=await baseMovieRemoteDataSource.getTopRatedMovies();
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MovieDetial>> getMovieDetails(MovieDetailsParameters parameters) async{
    final result=await baseMovieRemoteDataSource.getMovieDetails(parameters);
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Recommendations>>> getRecommendationMovie(MovieRecommendationParameters parameters) async{
   final result=await baseMovieRemoteDataSource.getMovieRecommendation(parameters);
   try{
     return Right(result);
   }on ServerException catch(failure){
     return Left(ServerFailure(failure.errorMessageModel.statusMessage));
   }
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMovie() async{
    final result=await baseMovieRemoteDataSource.getUpcomingMovies();
    try{
      return Right(result);
    }
    on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getSearchMovie(SearchParameters parameters) async{
    final result=await baseMovieRemoteDataSource.getSearchMovies(parameters);
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Videos>>> getMovieVideo(VideoParameters movieId)async {
    final result=await baseMovieRemoteDataSource.getMovieVideo(movieId);
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Keywords>> getKeywords(int movieId)async {
    final result=await baseMovieRemoteDataSource.getKeyword(movieId);
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }







}