
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../domain/entities/keywords.dart';
import '../../../domain/entities/movie_details.dart';
import '../../../domain/entities/recommendations.dart';
import '../../../domain/useCase/getKeywordUseCase.dart';
import '../../../domain/useCase/get_movie_details_useCase.dart';
import '../../../domain/useCase/get_movie_recommendation_useCase.dart';
import 'movies_details_states.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsStates>{
  MovieDetailsCubit( this.getMovieDetailsUseCase, this.getMovieRecommendationUseCase, this.getKeywordsUseCase) : super(InitialMovieDetailsState());
  static MovieDetailsCubit get(context)=>BlocProvider.of(context);

  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  bool movieDetailIsLoading=false;
  late MovieDetial movieDetial;
  void getMovieDetailsData(MovieDetailsParameters movieId)async{
    emit(MovieDetailsLoadingState());
    try{
      final result=await getMovieDetailsUseCase.call(movieId);
      //print(result);
      result.fold((l) => emit(MovieDetailsErrorState()), (r) {
        movieDetailIsLoading=true;
        movieDetial=r;
        emit(MovieDetailsSuccessState());
      });
      emit(MovieDetailsSuccessState());
    }
    catch (e){
      emit(MovieDetailsErrorState());
      movieDetailIsLoading=false;
      return print(e.toString());
    }
  }

  final GetMovieRecommendationUseCase getMovieRecommendationUseCase;
  bool recommendationIsLoading=false;
  List<Recommendations>movieRecommendations=[];
  void getMovieRecommendationsData(MovieRecommendationParameters recommendationId)async{
    emit(MovieRecommendationsLoadingState());
    try{
      emit(MovieRecommendationsSuccessState());
      final result=await getMovieRecommendationUseCase.call(recommendationId);
      print("reco="+result.toString());
      recommendationIsLoading=true;
      result.fold((l) => emit(MovieRecommendationsErrorState()), (r){
        emit(MovieRecommendationsSuccessState());
        recommendationIsLoading=true;
        movieRecommendations=r;
      });
    }catch (e){
      emit(MovieRecommendationsErrorState());
      return print(e.toString());
    }
  }


  final GetKeywordsUseCase getKeywordsUseCase;
  bool keywordsIsLoading=false;
  late Keywords keywords;
  void getKeywordsData(int movieId)async{
    emit(KeywordsLoadingState());
    try{
      final result=await getKeywordsUseCase(movieId);
      //print(result);
      result.fold((l) => emit(KeywordsErrorState()), (r) {
        keywordsIsLoading=true;
        keywords=r;
        print("kkkkkkkkk="+keywords.id.toString());
        emit(KeywordsSuccessState());
      });
      emit(KeywordsSuccessState());
    }
    catch (e){
      emit(KeywordsErrorState());
      keywordsIsLoading=false;
      return print(e.toString());
    }
  }

}