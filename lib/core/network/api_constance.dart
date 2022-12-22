class ApiConstance{
  static const String baseUrl="https://api.themoviedb.org/3";
  static const String apiKey="9c00afb9f04821fd4a07c79391873866";

  static const String nowPlayingMoviesPath="$baseUrl/movie/now_playing?api_key=$apiKey";
  static const String popularMoviesPath="$baseUrl/movie/popular?api_key=$apiKey";
  static const String topRatedMoviesPath="$baseUrl/movie/top_rated?api_key=$apiKey";
  static const String upcomingMoviesPath="$baseUrl/movie/upcoming?api_key=$apiKey";

  static  String movieDetailsPath(int movieId)=>"$baseUrl/movie/$movieId?api_key=$apiKey";
  static  String movieRecommendationPath(int RecommendationId)=>"$baseUrl/movie/$RecommendationId/recommendations?api_key=$apiKey";
  static  String videoPath(int videoId)=>"$baseUrl/movie/$videoId/videos?api_key=$apiKey";
  static  String movieSearchPath(String searchItem)=>"$baseUrl/search/movie?api_key=$apiKey&query=${searchItem}";

  static const String baseImageUrl="https://image.tmdb.org/t/p/w500";

}