

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/services/service_locator.dart';
import '../../domain/entities/video.dart';
import '../../domain/useCase/get_movie_video_usecase.dart';
import '../controller/video/video_cubit.dart';
import '../controller/video/video_states.dart';


class VideoScreen extends StatefulWidget {
  final VideoParameters videoParameters;

   VideoScreen({Key? key,required this.videoParameters}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context)=>VideoCubit(sl(),)..getVideoData(widget.videoParameters),

      child: BlocConsumer<VideoCubit,VideoStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=VideoCubit.get(context);
          List<Videos> video=cubit.videos;

          return Scaffold(
            appBar: AppBar(title: Text("Watch Trailers"),),
            body:(cubit.videoIsLoading==true)? YoutubePlayerBuilder(
                player: YoutubePlayer(controller: cubit.controller,),
                builder: (context,state){
                  return Column(

                    children: [
                      state,
                      Divider(),
                      Expanded(child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for(int i=0;i<cubit.videos.length;i++)
                              Container(
                                height: 100,
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        cubit.controller.load(cubit.videos[i].key);
                                        cubit.controller.play();

                                      },
                                      child: CachedNetworkImage(
                                        width: 150,
                                        imageUrl: YoutubePlayer.getThumbnail(
                                          videoId: cubit.videos[i].key,
                                          quality: ThumbnailQuality.medium,
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Padding(
                                      padding:  const EdgeInsets.all(8.0),
                                      child: Text(
                                        cubit.videos[i].name,

                                      ),
                                    )),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      )),
                    ],
                  );
                }
            ):Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
