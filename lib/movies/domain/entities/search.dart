import 'package:equatable/equatable.dart';

class Search extends Equatable{
  final int id;
  final String title;
  final String backdropPath;
  final String overview;


  const Search(
      {
        required this.id,
        required this.overview,
        required  this.title,
        required this.backdropPath,

      }
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    overview,
    title,
    backdropPath,
  ];



}