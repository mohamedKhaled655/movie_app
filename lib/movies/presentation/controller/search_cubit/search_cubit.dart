
import 'package:bloc/bloc.dart';
import 'package:film_app/movies/presentation/controller/search_cubit/search_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../domain/entities/movie.dart';
import '../../../domain/entities/search.dart';
import '../../../domain/useCase/get_search_usecase.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit(this.getSearchUseCase ) : super(InitialSearchState());
  static SearchCubit get(context)=>BlocProvider.of(context);

  final GetSearchUseCase getSearchUseCase;
   bool searchIsLoading=false;
   List<Movie>searchList=[];
  void getSearchMovie(SearchParameters searchParameters)async{
    emit(SearchLoadingState());
    try{
      final result=await getSearchUseCase(searchParameters);
      searchIsLoading=true;
      print("search="+result.toString());
      result.fold((l) => emit(SearchErrorState()), (r){
        emit(SearchSuccessState());
        searchIsLoading=true;
        searchList=r;
      });
      emit(SearchSuccessState());
    }catch (e){
      emit(SearchErrorState());
      searchIsLoading=false;
      return print("Error in search="+e.toString());
    }
  }
}