

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_app/movies/domain/useCase/get_movie_details_useCase.dart';
import 'package:film_app/movies/domain/useCase/get_movie_recommendation_useCase.dart';
import 'package:film_app/movies/presentation/controller/movie_details_cubit/movie_details_cubit.dart';
import 'package:film_app/movies/presentation/screens/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constance.dart';
import '../../../core/services/service_locator.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/useCase/get_movie_video_usecase.dart';
import '../controller/movie_details_cubit/movies_details_states.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieDetailsParameters parameters;
  final MovieRecommendationParameters recommendationParameters;
   MovieDetailsScreen({Key? key,required this.parameters,required this.recommendationParameters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>MovieDetailsCubit(sl(),sl(),sl())..getMovieDetailsData(parameters)..getMovieRecommendationsData(recommendationParameters)..getKeywordsData(parameters.movieId),

      child: BlocConsumer<MovieDetailsCubit,MovieDetailsStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=MovieDetailsCubit.get(context);


          String _showDuration(int runtime) {
            final int hours = runtime ~/ 60;
            final int minutes = runtime % 60;

            if (hours > 0) {
              return '${hours}h ${minutes}m';
            } else {
              return '${minutes}m';
            }
          }
          String _showGenres(List<Genres> genres) {
            String result = '';
            for (var genre in genres) {
              result += '${genre.name}, ';
            }

            if (result.isEmpty) {
              return result;
            }

            return result.substring(0, result.length - 2);
          }
          Widget _showRecommendations() {
            return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final recommendation = cubit.movieRecommendations[index];
                  return FadeInUp(
                    from: 20,
                    duration: const Duration(milliseconds: 500),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                      child: CachedNetworkImage(
                        imageUrl: "${ApiConstance.baseImageUrl}${recommendation.backdrop_path!}",
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[850]!,
                          highlightColor: Colors.grey[800]!,
                          child: Container(
                            height: 170.0,
                            width: 120.0,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        height: 180.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                childCount: cubit.movieRecommendations.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 0.7,
                crossAxisCount: 3,
              ),
            );
          }

          return Scaffold(
            // appBar: AppBar(title: Text(cubit.recommendationIsLoading==true?cubit.movieRecommendations[2].id.toString():"null"),),
            body:cubit.movieDetailIsLoading==true? CustomScrollView(
              key: const Key('movieDetailScrollView'),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black,
                              Colors.black,
                              Colors.transparent,
                            ],
                            stops: [0.0, 0.5, 1.0, 1.0],
                          ).createShader(
                            Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                          );
                        },
                        blendMode: BlendMode.dstIn,
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width,
                          imageUrl: "${ApiConstance.baseImageUrl}${cubit.movieDetial.backdrop_path}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: FadeInUp(
                    from: 20,
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cubit.movieDetial.title,
                              style: GoogleFonts.poppins(
                                fontSize: 23,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              )),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                  horizontal: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  cubit.movieDetial.release_date.split('-')[0],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20.0,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    (cubit.movieDetial.vote_average / 2).toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    '(${cubit.movieDetial.vote_average})',
                                    style: const TextStyle(
                                      fontSize: 1.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16.0),
                              Text(
                                _showDuration(cubit.movieDetial.runtime),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            cubit.movieDetial.overview,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Genres: ${_showGenres(cubit.movieDetial.genres)}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                  sliver: SliverToBoxAdapter(
                    child: FadeInUp(
                      from: 20,
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        'More like this'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),

                //////////////
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                  sliver: SliverToBoxAdapter(
                    child: TextButton(onPressed: (){
                      VideoParameters videoParameters=VideoParameters(movieId: parameters.movieId);
                      print(videoParameters.movieId);
                      Navigator.push( context, MaterialPageRoute(
                          builder: (context){
                            return VideoScreen(videoParameters: videoParameters);
                          }));
                    }, child: Text("Watch Trailer"),),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                  sliver: SliverToBoxAdapter(
                    child: TextButton(onPressed: (){
                       cubit.getKeywordsData(parameters.movieId);
                       print("k="+cubit.keywords.toString());


                    }, child: Text("key"),),
                  ),
                ),
                // Tab(text: 'More like this'.toUpperCase()),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
                  sliver: _showRecommendations(),
                ),
              ],
            ):Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

}
