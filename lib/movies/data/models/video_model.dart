

import '../../domain/entities/video.dart';

class VideoModel extends Videos{
  VideoModel({required String iso6391, required String iso31661, required String name, required String key, required String site, required int size, required String type, required bool official, required String publishedAt, required String id}) : super(iso6391: iso6391, iso31661: iso31661, name: name, key: key, site: site, size: size, type: type, official: official, publishedAt: publishedAt, id: id);


 factory VideoModel.fromJson(Map<String, dynamic> json) {
   return VideoModel(iso6391: json['iso_639_1'],
       iso31661: json['iso_3166_1'],
       name: json['name'],
       key: json['key'],
       site: json['site'],
       size: json['size'],
       type: json['type'],
       official: json['official'],
       publishedAt: json['published_at'],
       id: json['id']);
  }


}