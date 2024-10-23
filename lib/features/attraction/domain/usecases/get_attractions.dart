import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/features/attraction/domain/entities/attraction.dart';

import '../../data/datasources/failure.dart';
import '../repositories/attraction_repository.dart';

class GetAttractions {
  final AttractionRepository repository;

  GetAttractions(this.repository);

  Future<Either<Failure, List<Attraction>>> call() {
    return repository.getAttractions();
  }
}

