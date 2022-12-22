abstract class MovieStates{}

class MovieInitialState extends MovieStates{}
class NowPlayingMovieLoadingState extends MovieStates{}
class NowPlayingMovieSuccessState extends MovieStates{}
class NowPlayingMovieErrorState extends MovieStates{
  final String message;

  NowPlayingMovieErrorState({required this.message});

}

class PopularMovieLoadingState extends MovieStates{}
class PopularMovieSuccessState extends MovieStates{}
class PopularMovieErrorState extends MovieStates{
  final String message;

  PopularMovieErrorState({required this.message});
}

class TopRatedMovieLoadingState extends MovieStates{}
class TopRatedMovieSuccessState extends MovieStates{}
class TopRatedMovieErrorState extends MovieStates{
    final String message;

  TopRatedMovieErrorState({required this.message});
}

class UpcomingMovieLoadingState extends MovieStates{}
class UpcomingMovieSuccessState extends MovieStates{}
class UpcomingMovieErrorState extends MovieStates{
     final String message;

  UpcomingMovieErrorState({required this.message});
}

class MovieDetailsLoadingState extends MovieStates{}
class MovieDetailsSuccessState extends MovieStates{}
class MovieDetailsErrorState extends  MovieStates{
  final String message;

  MovieDetailsErrorState({required this.message});
}