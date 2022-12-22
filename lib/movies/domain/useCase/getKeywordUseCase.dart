import 'package:dartz/dartz.dart';


import '../../../core/error/failure.dart';
import '../../../core/usecases/base_usecase.dart';
import '../entities/keywords.dart';
import '../repository/base_movie_repo.dart';

class GetKeywordsUseCase extends BaseUseCase<Keywords,int>{
  final BaseMovieRepository baseMovieRepository;

  GetKeywordsUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, Keywords>> call(int parameters)async {
    return await baseMovieRepository.getKeywords(parameters);
  }
}