import 'package:equatable/equatable.dart';

class Keywords {
  int? id;
  List<KeywordsData>? keywordsData;

  Keywords({this.id, this.keywordsData});

  Keywords.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['keywords'] != null) {
      keywordsData = <KeywordsData>[];
      json['keywords'].forEach((v) {
        keywordsData!.add(new KeywordsData.fromJson(v));
      });
    }
  }


}

class KeywordsData {
  int? id;
  String? name;

  KeywordsData({this.id, this.name});

  KeywordsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }


}