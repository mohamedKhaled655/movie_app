import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:film_app/localization/lang_cubit/lang_cubit.dart';
import 'package:film_app/localization/lang_cubit/lang_states.dart';
import 'package:film_app/localization/translation_constants.dart';
import 'package:film_app/movies/presentation/component/app_dialog.dart';
import 'package:film_app/movies/presentation/screens/search/data_search.dart';
import 'package:film_app/movies/presentation/screens/see_more_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shimmer/shimmer.dart';
import 'package:wiredash/wiredash.dart';


import '../../../core/network/api_constance.dart';
import '../../../core/services/service_locator.dart';
import '../../../localization/app_localization.dart';
import '../../domain/useCase/get_movie_details_useCase.dart';
import '../../domain/useCase/get_movie_recommendation_useCase.dart';
import '../controller/movie_cubit.dart';
import '../controller/movie_states.dart';
import 'map/map_screen.dart';
import 'movie_detail.dart';

class MovieScreen extends StatelessWidget {
   MovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>MovieCubit(sl(),sl(),sl(),sl())..getNowPlayingData()..getPopularMovieData()..getTopRatedMovieData()..getUpcomingData(),

    child: BlocConsumer<MovieCubit,MovieStates>(
    listener: (BuildContext context,state){

    },
    builder: (BuildContext context,state){
    var cubit=MovieCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          title: Text(
            "Movie",
            style:GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
                onPressed: ()
            {
              showSearch(context: context, delegate: DataSearch(pop:(cubit.nowPlayingIsLoading==true) ?cubit.nowPlaying:[],popularTitle:(cubit.nowPlayingIsLoading==true)? cubit.title:[]));

              // SearchParameters searchItem=SearchParameters(searchItem: "O");
              //
              //
              //
              // Navigator.push( context, MaterialPageRoute(
              //     builder: (context){
              //       return SearchScreen(searchItem:searchItem,);
              //     }));
            },
                icon: Icon(Icons.search)),
            IconButton(
                onPressed: ()
            {
              Navigator.push( context, MaterialPageRoute(
                  builder: (context){
                    return MapScreen();
                  }));
            },
                icon: Icon(Icons.map)),
          ],
        ),
        drawer:Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
              padding: EdgeInsets.all(20),
             
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Text('Movie',style: TextStyle(fontSize: 40),),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('Favorite Movie'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
           ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('Feed back'),
            onTap: () {
              Navigator.pop(context);
              Wiredash.of(context).show(inheritMaterialTheme: true);
            },
          ),
            ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              showDialog(context: context, builder: (BuildContext context){
                return AppDialog(title:TranslationConstants.about ,
                 decription: TranslationConstants.aboutDescription,
                  buttonText: TranslationConstants.okay,
                  image: Image.network(
                    "https://www.themoviedb.org/assets/2/v4/marketing/deadpool-06f2a06d7a418ec887300397b6861383bf1e3b72f604ddd5f75bce170e81dce9.png",
                    height: 100,
                    ),
                  );
              });
            },
          ),
          ListTile(
            leading:   BlocBuilder<LanaguageCubit,LanguagesStates>(
            builder: (context,state){
              if(state is ChangeLanguageState)
              {
                return DropdownButton<String>(
                  
                  value: state.locale.languageCode,
                  items: ["ar","en"].map((items) {
                    return DropdownMenuItem<String>(
                      value: items,
                      child: Text(items=="en"?"English":"Arabic"),
                    
                    );
                  }).toList(),
                 onChanged: (String ? newValue){
                  if(newValue!=null){
                    //BlocProvider.of<LanaguageCubit>(context).changeLanguage(newValue);
                    context.read<LanaguageCubit>().changeLanguage(newValue);
                    
                  }
                 });
              }else{
                return Text("Languages");
              }
            },
          ),
            
            onTap: () {
              Navigator.pop(context);
            },
          ),
         
       
            ],
          ),
        ) ,
        body: SingleChildScrollView(
          key: const Key('movieScrollView'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5,),
              //Now Playing
              Container(
                // color: Colors.blueGrey.withOpacity(.3),
                child: FadeIn(

                  duration: Duration(milliseconds: 500),

                  child: CarouselSlider(

                    items: cubit.nowPlaying.map((e) => GestureDetector(
                      key: const Key('openMovieMinimalDetail'),
                      onTap: () {
                        /// TODO : NAVIGATE TO MOVIE DETAILS
                        MovieDetailsParameters movieId=MovieDetailsParameters(movieId: e.id);
                        MovieRecommendationParameters recommendationId=MovieRecommendationParameters(movieId: e.id);

                        Navigator.push( context, MaterialPageRoute(
                            builder: (context){
                              return  MovieDetailsScreen(parameters: movieId,recommendationParameters:recommendationId ,);
                            }));
                      },
                      child: Stack(

                        children: [

                          ShaderMask(
                            shaderCallback: (rect) {
                              return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  // fromLTRB

                                  Colors.black,
                                  Colors.black,

                                ],
                                stops: [ 0.3, 0.5,],
                              ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height),
                              );
                            },
                            blendMode: BlendMode.dstIn,
                            child:CachedNetworkImage(
                              width: double.maxFinite,
                              height: 300,
                              fit: BoxFit.cover,
                              imageUrl: "${ApiConstance.baseImageUrl}${e.backdropPath}",
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
                            // child: Image.network(
                            //   "https://image.tmdb.org/t/p/w500${e.backdropPath}",
                            //   fit: BoxFit.cover,
                            //
                            // ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.circle,
                                        color: Colors.redAccent,
                                        size: 16.0,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        'Now Playing'.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Text(
                                    e.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),).toList(),
                    options: CarouselOptions(
                      height: 250,
                      aspectRatio: 16/9,
                      viewportFraction: 1.2,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,

                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ),
              //Popular
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalization.of(context)!.translate(TranslationConstants.popular),
                          style: GoogleFonts.poppins(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.15,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //see more
                            Navigator.push( context, MaterialPageRoute(
                                builder: (context){
                                  return  SeeMoreScreen(result: cubit.popular,appBarTitle: "Popular Movie",moviesIsLoading: cubit.popularIsLoading,);
                                }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Text('See More'),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.0,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  (state is PopularMovieErrorState)?Container(child: Text(state.message),):FadeIn(
                    duration: const Duration(milliseconds: 500),
                    child: SizedBox(
                      height: 170.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: cubit.popular.length>5?5:cubit.popular.length,
                        itemBuilder: (context, index) {
                          final movie = cubit.popular[index];
                          return Container(
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
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              //up Coming
              Column(
                children: [
                  Container(
                    padding:EdgeInsets.fromLTRB(2, 8, 2, 8) ,
                    margin: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalization.of(context)!.translate(TranslationConstants.upcoming),
                          style: GoogleFonts.aBeeZee(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.15,),
                        ),
                        InkWell(
                          child: Row(
                            children: [
                              Text(
                                AppLocalization.of(context)!.translate(TranslationConstants.seeMore),
                                style: GoogleFonts.aBeeZee(

                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.15,),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16.0,
                              ),
                            ],
                          ),
                          onTap: (){
                            Navigator.push( context, MaterialPageRoute(
                                builder: (context){
                                  return  SeeMoreScreen(result: cubit.upcoming,appBarTitle: "Upcoming Movie",moviesIsLoading: cubit.upcomingIsLoading,);
                                }));
                          },
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 170,

                    child: FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: SizedBox(
                        height: 170.0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount: cubit.upcoming.length>5?5:cubit.upcoming.length,
                          itemBuilder: (context, index) {
                            final movie = cubit.upcoming[index];
                            return Container(
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
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
             //Top Rated
              Column(
                children: [
                  Container(
                    padding:EdgeInsets.fromLTRB(2, 8, 2, 8) ,
                    margin: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalization.of(context)!.translate(TranslationConstants.topRated),
                          style: GoogleFonts.aBeeZee(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.15,),
                        ),
                        InkWell(
                          child: Row(
                            children: [
                              Text(
                                AppLocalization.of(context)!.translate(TranslationConstants.seeMore),
                                style: GoogleFonts.aBeeZee(

                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.15,),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16.0,
                              ),
                            ],
                          ),
                          onTap: (){
                            Navigator.push( context, MaterialPageRoute(
                                builder: (context){
                                  return  SeeMoreScreen(result: cubit.topRated,appBarTitle: "Top Rated Movie",moviesIsLoading: cubit.topRatedIsLoading,);
                                }));
                          },
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 170,

                    child: FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: SizedBox(
                        height: 170.0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount: cubit.topRated.length>5?5:cubit.topRated.length,
                          itemBuilder: (context, index) {
                            final movie = cubit.topRated[index];
                            return Container(
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
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
    ));
  }
}

