import 'package:dartz/dartz.dart';
import '../../data/datasources/failure.dart';
import '../entities/attraction.dart';

abstract class AttractionRepository {
  Future<Either<Failure, List<Attraction>>> getAttractions();
}

