

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../core/usecases/base_usecase.dart';
import '../../domain/entities/movie.dart';
import '../../domain/useCase/get_now_playing_useCase.dart';
import '../../domain/useCase/get_popular_movie_useCase.dart';
import '../../domain/useCase/get_topRated_movie_useCase.dart';
import '../../domain/useCase/get_upcoming_usecase.dart';
import 'movie_states.dart';

class MovieCubit extends Cubit<MovieStates>{
  MovieCubit(this.getNowPlayingMoviesUseCAse, this.getPopularMoviesUseCase, this.getTopRatedMoviesUseCase, this.getUpcomingMovieUseCase,

      ) : super(MovieInitialState());
  static MovieCubit get(context)=>BlocProvider.of(context);


  //now Playing
  final GetNowPlayingMoviesUseCAse getNowPlayingMoviesUseCAse;
  List<Movie>nowPlaying=[];
  bool nowPlayingIsLoading=false;
  void getNowPlayingData()async{
    emit(NowPlayingMovieLoadingState());
    try{
      // emit(MovieSuccessState());
      //بستعمل الطريقه دي لو انا عايزه يجيب الداتا كل مره يستعدي الفانكشن
      // BaseMovieRemoteDataSource baseMovieRemoteDataSource=MovieRemoteDataSource();
      // BaseMovieRepository baseMovieRepository=MoviesRepository(baseMovieRemoteDataSource);
     // final result= await GetNowPlayingMoviesUseCAse(baseMovieRepository).execute();

      final result= await getNowPlayingMoviesUseCAse(const NoParameters());

      nowPlayingIsLoading=true;
     // result.fold((l) => null, (r) => null);
       result.fold((l) => emit(NowPlayingMovieErrorState(message: l.message)), (r) {
         emit(NowPlayingMovieSuccessState());
         nowPlaying=r;
       });

      //print(result);
      //print("rrrrrrr="+nowPlaying.toString());
    }catch(e){

      emit(NowPlayingMovieErrorState(message: e.toString()));
      nowPlayingIsLoading=false;
      return print(e.toString());

    }

  }

//Popular
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  List<Movie>popular=[];
  List title=[];
  bool popularIsLoading=false;
  void getPopularMovieData()async{
    emit(PopularMovieLoadingState());
    try{
      emit(PopularMovieSuccessState());

      final result=await getPopularMoviesUseCase( const NoParameters());
      //print("pop="+result.toString());
      popularIsLoading=true;
      result.fold((l) => emit(PopularMovieErrorState(message: l.message)), (r) {
        emit(PopularMovieSuccessState());
        popular=r;
        title=r.map((e) => e.title).toList();
        
      });

      print("popular result="+popular.toString());
    }
    catch(e){
      emit(PopularMovieErrorState(message: e.toString()));
      return print(e.toString());
    }
  }

  //upComing
  final GetUpcomingMovieUseCase getUpcomingMovieUseCase;
  List<Movie>upcoming=[];
  bool upcomingIsLoading=false;
  void getUpcomingData()async{
    emit(UpcomingMovieLoadingState());
    try{
      final result=await getUpcomingMovieUseCase(const NoParameters());
      upcomingIsLoading=true;
      result.fold((l) => emit(UpcomingMovieErrorState(message: l.message)), (r) {
        emit(UpcomingMovieSuccessState());
        upcomingIsLoading=true;
        upcoming=r;
        print("upcoming="+upcoming.toString());
      });
      emit(UpcomingMovieSuccessState());
    }catch (e){
      emit(UpcomingMovieErrorState(message: e.toString()));
      upcomingIsLoading=false;
      return print("upComing Error="+e.toString());
    }
  }




  //Top Rated
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  List<Movie>topRated=[];
  bool topRatedIsLoading=false;
  void getTopRatedMovieData()async{
    emit(TopRatedMovieLoadingState());
    try{
      emit(TopRatedMovieSuccessState());

      final result=await getTopRatedMoviesUseCase(const NoParameters());
      //print("pop="+result.toString());
      topRatedIsLoading=true;
      result.fold((l) => emit(TopRatedMovieErrorState(message: l.message)), (r) {
        emit(TopRatedMovieSuccessState());
        topRated=r;
      });

      print("topRated result="+topRated.toString());
    }
    catch(e){
      emit(TopRatedMovieErrorState(message: e.toString()));
      return print("error="+e.toString());
    }
  }




}