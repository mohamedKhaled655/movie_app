abstract class MovieDetailsStates{}
class InitialMovieDetailsState extends MovieDetailsStates{}

class MovieDetailsLoadingState extends MovieDetailsStates{}
class MovieDetailsSuccessState extends MovieDetailsStates{}
class MovieDetailsErrorState extends  MovieDetailsStates{}

class MovieRecommendationsLoadingState extends MovieDetailsStates{}
class MovieRecommendationsSuccessState extends MovieDetailsStates{}
class MovieRecommendationsErrorState extends  MovieDetailsStates{}

class KeywordsLoadingState extends MovieDetailsStates{}
class KeywordsSuccessState extends MovieDetailsStates{}
class KeywordsErrorState extends  MovieDetailsStates{}