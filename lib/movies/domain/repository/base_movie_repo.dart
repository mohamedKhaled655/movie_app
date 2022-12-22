import 'package:dartz/dartz.dart';


import '../../../core/error/failure.dart';
import '../entities/keywords.dart';
import '../entities/movie.dart';
import '../entities/movie_details.dart';
import '../entities/recommendations.dart';
import '../entities/video.dart';
import '../useCase/get_movie_details_useCase.dart';
import '../useCase/get_movie_recommendation_useCase.dart';
import '../useCase/get_movie_video_usecase.dart';
import '../useCase/get_search_usecase.dart';

abstract class BaseMovieRepository{

  Future<Either<Failure,List<Movie>>>getNowPlayingMovies();
  Future<Either<Failure,List<Movie>>>getTopRatedMovies();
  Future<Either<Failure,List<Movie>>>getPopularMovies();
  Future<Either<Failure,List<Movie>>>getUpcomingMovie();

  Future<Either<Failure,MovieDetial>>getMovieDetails(MovieDetailsParameters parameters);

  Future<Either<Failure,List<Recommendations>>>getRecommendationMovie(MovieRecommendationParameters parameters);

  // Future<Either<Failure,List<Movie>>>getSearchMovie(SearchParameters searchParameters);
  Future<Either<Failure,List<Movie>>>getSearchMovie(SearchParameters parameters);

   Future<Either<Failure,List<Videos>>>getMovieVideo(VideoParameters movieId);

   Future<Either<Failure,Keywords>>getKeywords(int movieId);
}