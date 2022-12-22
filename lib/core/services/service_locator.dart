

import 'package:get_it/get_it.dart';

import '../../movies/data/dataSource/movie_remote_data_source.dart';
import '../../movies/data/repository/movies_repository.dart';
import '../../movies/domain/repository/base_movie_repo.dart';
import '../../movies/domain/useCase/getKeywordUseCase.dart';
import '../../movies/domain/useCase/get_movie_details_useCase.dart';
import '../../movies/domain/useCase/get_movie_recommendation_useCase.dart';
import '../../movies/domain/useCase/get_movie_video_usecase.dart';
import '../../movies/domain/useCase/get_now_playing_useCase.dart';
import '../../movies/domain/useCase/get_popular_movie_useCase.dart';
import '../../movies/domain/useCase/get_search_usecase.dart';
import '../../movies/domain/useCase/get_topRated_movie_useCase.dart';
import '../../movies/domain/useCase/get_upcoming_usecase.dart';

final sl = GetIt.instance;

class ServiceLocator{
  void init(){
    //use CAse
    sl.registerLazySingleton(() => GetNowPlayingMoviesUseCAse(sl()));
    sl.registerLazySingleton(() => GetTopRatedMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetPopularMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetMovieDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetMovieRecommendationUseCase(sl()));
    sl.registerLazySingleton(() => GetUpcomingMovieUseCase(sl()));
    sl.registerLazySingleton(() => GetSearchUseCase(sl()));
    sl.registerLazySingleton(() => GetMovieVideoUseCase(sl()));
    sl.registerLazySingleton(() => GetKeywordsUseCase(sl()));



    //Repository
    sl.registerLazySingleton<BaseMovieRepository>(() => MoviesRepository(sl()));

    //Data source
    //registerLazySingleton دي معناها ان ال object اللي انا بكريته متستعملوش الا لما انا استدعيه
    sl.registerLazySingleton<BaseMovieRemoteDataSource>(() => MovieRemoteDataSource());


  }
}