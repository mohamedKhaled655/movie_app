
import 'package:bloc/bloc.dart';
import 'package:film_app/movies/presentation/controller/video/video_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../domain/entities/video.dart';
import '../../../domain/useCase/get_movie_video_usecase.dart';

class VideoCubit extends Cubit<VideoStates>{
  VideoCubit(this.getMovieVideoUseCase) : super(InitialVideoState());
  static VideoCubit get(context)=>BlocProvider.of(context);

  final GetMovieVideoUseCase getMovieVideoUseCase;
  bool videoIsLoading=false;
  List<Videos>videos=[];
late  YoutubePlayerController controller;
  void getVideoData(VideoParameters videoParameters)async{
    emit(VideoLoadingState());
    try{
      emit(VideoSuccessState());
      final result=await getMovieVideoUseCase.call(videoParameters);
      print("vide="+result.toString());
      videoIsLoading=true;
      result.fold((l) => emit(VideoErrorState()), (r){
        emit(VideoSuccessState());
        videoIsLoading=true;
        videos=r;
      });
       controller=YoutubePlayerController(
        initialVideoId:videos[0].key,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: true,
        ),
      );
    }catch (e){
      emit(VideoErrorState());
      videoIsLoading=false;
      return print(e.toString());
    }
  }
}