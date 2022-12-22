
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constance.dart';
import '../../domain/useCase/get_movie_details_useCase.dart';
import '../../domain/useCase/get_movie_recommendation_useCase.dart';
import 'movie_detail.dart';

class SeeMoreScreen extends StatelessWidget {
  late List result;
  late String appBarTitle;
  bool moviesIsLoading;
   SeeMoreScreen({Key? key,required this.result,required this.appBarTitle,this.moviesIsLoading=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body:(moviesIsLoading==true)? SingleChildScrollView(
        child:  SizedBox(
          
          child: FadeIn(
            duration: const Duration(milliseconds: 500),
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: result.length,
              itemBuilder: (context, index) {
                final movie = result[index];
                return Row(

                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: () {
                          /// TODO : NAVIGATE TO MOVIE DETAILS
                          MovieDetailsParameters movieId=MovieDetailsParameters(movieId: movie.id);
                          MovieRecommendationParameters recommendationId=MovieRecommendationParameters(movieId: movie.id);
                          Navigator.push( context, MaterialPageRoute(
                              builder: (context){
                                return  MovieDetailsScreen(parameters: movieId,recommendationParameters:recommendationId ,);
                              }));
                        },
                        child: ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                          child: CachedNetworkImage(
                            width: 120.0,
                            fit: BoxFit.cover,
                            imageUrl: "${ApiConstance.baseImageUrl}${movie.backdropPath}",
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
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start ,
                      children: [
                        Text(result[index].title),
                        Text(result[index].releaseDate),
                      ],
                    )),
                  ],
                );
              }, separatorBuilder: (BuildContext context, int index) =>Divider(),

            ),
          ),
        ),
      ):const Center(child: CircularProgressIndicator()),
    );
  }
}
