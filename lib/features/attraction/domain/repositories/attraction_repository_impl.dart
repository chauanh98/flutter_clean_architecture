import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../data/datasources/failure.dart';
import '../../data/datasources/remote_data_source.dart';
import '../../domain/entities/attraction.dart';
import '../../domain/repositories/attraction_repository.dart';

class AttractionRepositoryImpl implements AttractionRepository {
  final RemoteDataSource remoteDataSource;

  AttractionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Attraction>>> getAttractions() async {
    try {
      final attractionModels = await remoteDataSource.fetchAttractions();

      final attractions = attractionModels.map((model) => model.toEntity()).toList();

      return Right(attractions);
    } on ServerException {
      return const Left(ServerFailure('Failed to fetch data from server.'));
    } on NetworkException {
      return const Left(NetworkFailure('No internet connection.'));
    }
  }
}



