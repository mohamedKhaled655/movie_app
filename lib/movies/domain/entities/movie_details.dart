import 'package:equatable/equatable.dart';

class MovieDetial extends Equatable{

  final String backdrop_path;
  final int id;
  final String overview;
  final String release_date;
  final int runtime;
  final String title;
  final double vote_average;
  final List<Genres>genres;

  const MovieDetial(
      {
       required this.backdrop_path,
     required this.id,
        required this.overview,
        required this.release_date,
        required this.runtime,
        required this.title,
        required this.vote_average,
        required this.genres,
      });

  @override
  // TODO: implement props
  List<Object?> get props => [
    backdrop_path,
    id,overview,release_date,runtime,
    title,vote_average,genres,
  ];

}

class Genres extends Equatable{
  final int id;
  final String name;

  const Genres({required this.id,required this.name});

  @override
  // TODO: implement props
  List<Object?> get props =>[id,name];

}