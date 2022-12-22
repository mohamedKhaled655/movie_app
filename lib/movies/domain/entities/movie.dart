import 'package:equatable/equatable.dart';

class Movie extends Equatable{
  final int id;
  final String title;
  final String backdropPath;
  final List<int> genreIds;
  final String overview;
  final String releaseDate;
  final dynamic voteAverage;

  const Movie(
      {
     required this.id,
     required this.overview,
    required  this.title,
     required this.backdropPath,
     required this.genreIds,
     required this.voteAverage,
        required this.releaseDate
      }
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    overview,
    title,
    backdropPath,
    genreIds,
    voteAverage,releaseDate
  ];


}
