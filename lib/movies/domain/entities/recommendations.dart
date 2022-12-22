import 'package:equatable/equatable.dart';

class Recommendations extends Equatable {
  final int id;
  final String ? backdrop_path;

  Recommendations({required this.id,required this.backdrop_path});

  @override
  // TODO: implement props
  List<Object?> get props =>[id,backdrop_path];
}